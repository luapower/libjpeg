
--libjpeg ffi binding.
--Written by Cosmin Apreutesei. Public domain.

if not ... then
	--require'libjpeg_test'
	--require'libjpeg_demo'
	require'imageload'
	return
end

local ffi = require'ffi'
local bit = require'bit'
local glue = require'glue'
local jit = require'jit'
require'libjpeg_h'
local C = ffi.load'jpeg'

ffi.cdef'void *memmove(void *dest, const void *src, size_t n);'

local LIBJPEG_VERSION = 62

--NOTE: images with C.JCS_UNKNOWN format are not supported.
local formats = {
	[C.JCS_GRAYSCALE]= 'g8',
	[C.JCS_YCbCr]    = 'ycc8',
	[C.JCS_CMYK]     = 'cmyk8',
	[C.JCS_YCCK]     = 'ycck8',
	[C.JCS_RGB]      = 'rgb8',
	--libjpeg-turbo only
	[C.JCS_EXT_RGB]  = 'rgb8',
	[C.JCS_EXT_BGR]  = 'bgr8',
	[C.JCS_EXT_RGBX] = 'rgbx8',
	[C.JCS_EXT_BGRX] = 'bgrx8',
	[C.JCS_EXT_XRGB] = 'xrgb8',
	[C.JCS_EXT_XBGR] = 'xbgr8',
	[C.JCS_EXT_RGBA] = 'rgba8',
	[C.JCS_EXT_BGRA] = 'bgra8',
	[C.JCS_EXT_ARGB] = 'argb8',
	[C.JCS_EXT_ABGR] = 'abgr8',
}

local channel_count = {
	g8 = 1, ycc8 = 3, cmyk8 = 4, ycck8 = 4, rgb8 = 3, bgr8 = 3,
	rgbx8 = 4, bgrx8 = 4, xrgb8 = 4, xbgr8 = 4,
	rgba8 = 4, bgra8 = 4, argb8 = 4, abgr8 = 4,
}

local color_spaces = glue.index(formats)

--all conversions that libjpeg implements: {source -> {dest -> _}}
local conversions = {
	ycc8 = glue.index{'ycc8', 'rgb8', 'bgr8', 'rgba8', 'bgra8', 'argb8',
		'abgr8', 'rgbx8', 'bgrx8', 'xrgb8', 'xbgr8', 'g8'},
	g8 = glue.index{'g8', 'rgb8', 'bgr8', 'rgba8', 'bgra8', 'argb8', 'abgr8',
		'rgbx8', 'bgrx8', 'xrgb8', 'xbgr8'},
	ycck8 = glue.index{'ycck8', 'cmyk8'},
}

local function accepts(src_format, dst_formats)
	local t = assert(conversions[src_format], 'invalid source format')
	if type(dst_formats) == 'string' then
		return t[dst_formats] and true or false
	else
		local dt = {}
		for fmt in pairs(dst_formats) do
			if t[fmt] then
				dt[fmt] = true
			end
		end
		return dt
	end
end

--given a row stride, return the next larger stride that is a multiple of 4.
local function pad_stride(stride)
	return bit.band(stride + 3, bit.bnot(3))
end

--create a callback manager object and its destructor.
local function callback_manager(mgr_ctype, callbacks)
	local mgr = ffi.new(mgr_ctype)
	local cbt = {}
	for k,f in pairs(callbacks) do
		if type(f) == 'function' then
			cbt[k] = ffi.cast(string.format('jpeg_%s_callback', k), f)
			mgr[k] = cbt[k]
		else
			mgr[k] = f
		end
	end
	local function free()
		for k,cb in pairs(cbt) do
			mgr[k] = nil --anchor mgr
			cb:free()
		end
	end
	return mgr, free
end

--end-of-image marker, inserted on EOF for partial display of broken images.
local JPEG_EOI = string.char(0xff, 0xD9):rep(32)

local dct_methods = {
	accurate = C.JDCT_ISLOW,
	fast = C.JDCT_IFAST,
	float = C.JDCT_FLOAT,
}

local ccptr_ct = ffi.typeof'const uint8_t*' --const prevents copying

--create and setup a error handling object.
local function jpeg_err(t)
	local jerr = ffi.new'jpeg_error_mgr'
	C.jpeg_std_error(jerr)
	local err_cb = ffi.cast('jpeg_error_exit_callback', function(cinfo)
		local buf = ffi.new'uint8_t[512]'
		cinfo.err.format_message(cinfo, buf)
		error(ffi.string(buf))
	end)
	local warnbuf --cache this buffer because there are a ton of messages
	local emit_cb = ffi.cast('jpeg_emit_message_callback', function(cinfo, level)
		if t.warning then
			warnbuf = warnbuf or ffi.new'uint8_t[512]'
			cinfo.err.format_message(cinfo, warnbuf)
			t.warning(ffi.string(warnbuf), level)
		end
	end)
	local function free() --anchor jerr, err_cb, emit_cb
		C.jpeg_std_error(jerr) --reset jerr fields
		err_cb:free()
		emit_cb:free()
	end
	jerr.error_exit = err_cb
	jerr.emit_message = emit_cb
	return jerr, free
end

--create a top-down or bottom-up array of rows pointing to a bitmap buffer.
local function rows_buffer(h, bottom_up, data, stride)
	local rows = ffi.new('uint8_t*[?]', h)
	if bottom_up then
		for i=0,h-1 do
			rows[h-1-i] = data + (i * stride)
		end
	else
		for i=0,h-1 do
			rows[i] = data + (i * stride)
		end
	end
	return rows
end

local function open(t)

	--normalize args
	if type(t) == 'function' then
		t = {read = t}
	end

	--create a global free function and finalizer accumulator
	local free_t = {} --{free1, ...}
	local function free()
		if not free_t then return end
		for i = #free_t, 1, -1 do
			free_t[i]()
		end
		free_t = nil
	end
	local function finally(func)
		table.insert(free_t, func)
	end

	--create the state object and output image
	local cinfo = ffi.new'jpeg_decompress_struct'
	local jpg = {}

	jpg.free = free

	--setup error handling
	local jerr, jerr_free = jpeg_err(t)
	cinfo.err = jerr
	finally(jerr_free)

	--init state
	C.jpeg_CreateDecompress(cinfo,
		t.lib_version or LIBJPEG_VERSION,
		ffi.sizeof(cinfo))

	finally(function()
		C.jpeg_destroy_decompress(cinfo)
		cinfo = nil
	end)

	ffi.gc(cinfo, free)

	--state variables
	local decompress_started, start_decompress, finish_decompress
	local output_started, start_output, finish_output
	local options_set

	--create the buffer filling function for suspended I/O
	local partial_loading = t.partial_loading ~= false
	local read = t.read
	local sz = t.read_buffer_size or 4096
	local buf = t.read_buffer or ffi.new('char[?]', sz)
	local bytes_to_skip = 0

	local function fill_input_buffer()
		while bytes_to_skip > 0 do
			local bytes_skipped = read(nil, bytes_to_skip)
			assert(bytes_skipped > 0, 'eof')
			bytes_to_skip = bytes_to_skip - bytes_skipped
		end
		local ofs = tonumber(cinfo.src.bytes_in_buffer)
		--move the data after the restart point to the start of the buffer
		ffi.C.memmove(buf, cinfo.src.next_input_byte, ofs)
		--move the restart point to the start of the buffer
		cinfo.src.next_input_byte = buf
		--fill the rest of the buffer
		local sz = sz - ofs
		assert(sz > 0, 'buffer too small')
		local readsz = read(buf + ofs, sz)
		if readsz == 0 then --eof
			assert(partial_loading, 'eof')
			readsz = #JPEG_EOI
			assert(readsz <= sz, 'buffer too small')
			ffi.copy(buf + ofs, JPEG_EOI)
			jpg.partial = true
		end
		cinfo.src.bytes_in_buffer = ofs + readsz
	end

	--fill the input buffer and consume it in a loop which stops when there
	--are no more bytes available to be read or an end-of-image marker is found
	local function read_more()
		while true do
			fill_input_buffer()
			if not (decompress_started and t.read_more and t.read_more()) then
				return
			end
			local ret = C.jpeg_consume_input(cinfo)
			if ret == C.JPEG_REACHED_EOI then return end
		end
	end

	--create source callbacks and set up a source manager with them
	local cb = {}
	cb.init_source = glue.pass
	cb.term_source = glue.pass
	cb.resync_to_restart = C.jpeg_resync_to_restart

	if t.suspended_io == false then --TODO: add support for t.read_more()
		function cb.fill_input_buffer(cinfo)
			local readsz = read(buf, sz)
			if readsz == 0 then --eof
				assert(partial_loading, 'eof')
				readsz = #JPEG_EOI
				assert(readsz <= sz, 'buffer too small')
				ffi.copy(buf, JPEG_EOI)
				jpg.partial = true
			end
			cinfo.src.bytes_in_buffer = readsz
			cinfo.src.next_input_byte = buf
			return true
		end
		function cb.skip_input_data(cinfo, sz)
			if sz <= 0 then return end
			while sz > cinfo.src.bytes_in_buffer do
				sz = sz - cinfo.src.bytes_in_buffer
				cb.fill_input_buffer(cinfo) --TODO: optimize by null-reading
			end
			cinfo.src.next_input_byte = cinfo.src.next_input_byte + sz
			cinfo.src.bytes_in_buffer = cinfo.src.bytes_in_buffer - sz
		end
	else
		function cb.fill_input_buffer(cinfo)
			return false --suspended I/O mode
		end
		function cb.skip_input_data(cinfo, sz)
			if sz <= 0 then return end
			if sz >= cinfo.src.bytes_in_buffer then
				bytes_to_skip = tonumber(sz - cinfo.src.bytes_in_buffer)
				cinfo.src.bytes_in_buffer = 0
			else
				bytes_to_skip = 0
				cinfo.src.bytes_in_buffer = cinfo.src.bytes_in_buffer - sz
				cinfo.src.next_input_byte = cinfo.src.next_input_byte + sz
			end
		end
	end

	local mgr, free_mgr = callback_manager('jpeg_source_mgr', cb)
	cinfo.src = mgr
	finally(free_mgr)
	cinfo.src.bytes_in_buffer = 0
	cinfo.src.next_input_byte = nil

	--state-querying and state-changing functions
	function jpg.complete(jpg)
		return C.jpeg_input_complete(cinfo) == 1
	end

	function jpg.input_scan(jpg)
		return decompress_started and cinfo.input_scan_number or nil
	end

	function jpg.output_scan(jpg)
		return output_started and cinfo.output_scan_number or nil
	end

	function start_decompress()
		if decompress_started then return end
		assert(options_set, 'decoding options not set')
		while C.jpeg_start_decompress(cinfo) == 0 do
			read_more()
		end
		decompress_started = true
	end
	jit.off(start_decompress)

	function finish_decompress()
		if not decompress_started then return end
		finish_output()
		while C.jpeg_finish_decompress(cinfo) == 0 do
			read_more()
		end
		decompress_started = false
		options_set = false
	end
	jit.off(finish_decompress)

	function	start_output(scan_num)
		finish_output()
		start_decompress()
		local scan_num = scan_num or jpg:input_scan()
		while C.jpeg_start_output(cinfo, scan_num) == 0 do
			read_more()
		end
		output_started = true
	end
	jit.off(start_output)

	function finish_output()
		if not output_started then return end
		while C.jpeg_finish_output(cinfo) == 0 do
			read_more()
		end
		output_started = false
	end
	jit.off(finish_output)

	--read file header and extract metadata
	local function read_header()

		while C.jpeg_read_header(cinfo, 1) == C.JPEG_SUSPENDED do
			read_more()
		end

		jpg.w = cinfo.image_width
		jpg.h = cinfo.image_height
		jpg.format = formats[tonumber(cinfo.jpeg_color_space)]
		assert(cinfo.num_components == channel_count[jpg.format])
		jpg.progressive = C.jpeg_has_multiple_scans(cinfo) ~= 0

		jpg.jfif = cinfo.saw_JFIF_marker == 1 and {
			maj_ver = cinfo.JFIF_major_version,
			min_ver = cinfo.JFIF_minor_version,
			density_unit = cinfo.density_unit,
			x_density = cinfo.X_density,
			y_density = cinfo.Y_density,
		} or nil

		jpg.adobe = cinfo.saw_Adobe_marker == 1 and {
			transform = cinfo.Adobe_transform,
		} or nil

	end
	jit.off(read_header)

	local ok, err = pcall(read_header)
	if not ok then
		free()
		return nil, err
	end

	--this can be called after the current file is complete in order to
	--read another file from the same stream.
	local function new_image()
		assert(jpg:complete(), 'current image not complete')
		finish_decompress()
		read_header()
	end
	jit.new_image = glue.protect(new_image)

	--check accepted output pixel formats
	function jpg:accepts(accept)
		if not jpg.format then
			if type(accept) == 'string' then
				return false
			else
				return {}
			end
		end
		return accepts(jpg.format, accept)
	end

	--return output image dimensions according to decoding options
	function jpg:dimensions(t)
		assert(not decompress_started, 'decompression already started')

		--normalize args
		if type(t) == 'string' then
			t = {format = t}
		end

		--validate options
		local format = t.format or jpg.format
		assert(jpg:accepts(format), 'invalid format')
		local out_color_space = assert(color_spaces[format])
		local out_components = assert(channel_count[format])
		local dct_method = assert(dct_methods[t.dct_method or 'accurate'], 'invalid dct_method')

		--set options
		cinfo.out_color_space = out_color_space
		cinfo.output_components = out_components
		cinfo.scale_num = t.scale_num or 1
		cinfo.scale_denom = t.scale_denom or 1
		cinfo.dct_method = dct_method
		cinfo.do_fancy_upsampling = t.fancy_upsampling or false
		cinfo.do_block_smoothing = t.block_smoothing or false
		cinfo.buffered_image = jpg.progressive and 1 or 0 --multi-scan reading
		options_set = true --unlock decoding

		--compute and return output bitmap dimensions and format
		C.jpeg_calc_output_dimensions()
		local bypp = cinfo.output_components
		local w = cinfo.output_width
		local h = cinfo.output_height
		local min_stride = w * bypp
		local stride = t.stride or min_stride
		local stride = t.stride_aligned and pad_stride(stride) or stride
		local stride = math.max(stride, min_stride)
		return w, h, stride, format
	end

	--make a bitmap according to decoding options
	function jpg:bitmap(t)
		local w, h, stride, format = jpg:dimensions(t)
		local h = t.h or h
		assert(h > 0, 'invalid height')
		local size = stride * h
		local bmp = {
			w = w,
			h = h,
			stride = stride,
			size = size,
			format = format,
		}
		bmp.data = t.alloc and t.alloc(size) or ffi.new('uint8_t[?]', size)
		return bmp
	end

	local out_bmp, rows, rows_h

	jpg.start_output = glue.protect(function(bmp)
		--validate the dest. bitmap
		local format = bmp.format or jpg.format
		assert(jpg:accepts(format), 'invalid format')
		local bypp = cinfo.output_components
		local w = cinfo.output_width
		local min_stride = w * bypp
		assert(bmp.stride >= min_stride, 'stride too small')
		--create pointer array to rows
		local rows_h = math.min(cinfo.output_height, bmp.h)
		local rows = rows_buffer(rows_h, bmp.bottom_up, bmp.data, bmp.stride)
		out_bmp = bmp
		start_output()
	end)

	local function next_row()
		assert(output_started, 'output not started')
		if cinfo.output_scanline == h then return end
		local i = cinfo.output_scanline % rows_h
		while C.jpeg_read_scanlines(cinfo, rows + i, 1) < 1 do
			read_more()
		end
	end
	jpg.next_row = glue.protect(next_row)

	jpg.finish_output = glue.protect(finish_output)

	--[[
	local function decode(bmp)
		start_output()

		--validate the dest. bitmap
		local format = bmp.format or jpg.format
		assert(jpg:accepts(format), 'invalid format')
		local bypp = cinfo.output_components
		local w = cinfo.output_width
		local h = cinfo.output_height
		local min_stride = w * bypp
		assert(bmp.stride >= min_stride, 'stride too small')

		local dh = math.min(h, bmp.h)
		local rows = rows_buffer(dh, bmp.bottom_up, bmp.data, bmp.stride)
		while cinfo.output_scanline < h do
			local i = cinfo.output_scanline % dh
			local n = math.min(h - i, cinfo.rec_outbuf_height)
			while C.jpeg_read_scanlines(cinfo, rows + i, n) < n do
				read_more()
			end
		end

		finish_output()
	end
	jit.off(decode)
	jpg.decode = glue.protect(decode)
	]]

	return jpg
end

jit.off(open, true) --can't call error() from callbacks called from C

local save = glue.protect(function(t)

	return glue.fcall(function(finally)

		--create the state object
		local cinfo = ffi.new'jpeg_compress_struct'

		--setup error handling
		local jerr, jerr_free = jpeg_err(t)
		cinfo.err = jerr
		finally(jerr_free)

		--init state
		C.jpeg_CreateCompress(cinfo,
			t.lib_version or LIBJPEG_VERSION,
			ffi.sizeof(cinfo))

		finally(function()
			C.jpeg_destroy_compress(cinfo)
		end)

		local write = t.write
		local finish = t.finish or glue.pass

		--create the dest. buffer
		local sz = t.write_buffer_size or 4096
		local buf = t.write_buffer or ffi.new('char[?]', sz)

		--create destination callbacks
		local cb = {}

		function cb.init_destination(cinfo)
			cinfo.dest.next_output_byte = buf
			cinfo.dest.free_in_buffer = sz
		end

		function cb.term_destination(cinfo)
			write(buf, sz - cinfo.dest.free_in_buffer)
			finish()
		end

		function cb.empty_output_buffer(cinfo)
			write(buf, sz)
			cb.init_destination(cinfo)
			return true
		end

		--create a destination manager and set it up
		local mgr, free_mgr = callback_manager('jpeg_destination_mgr', cb)
		cinfo.dest = mgr
		finally(free_mgr) --the finalizer anchors mgr through free_mgr!

		--set the source format
		cinfo.image_width = t.bitmap.w
		cinfo.image_height = t.bitmap.h
		cinfo.in_color_space =
			assert(color_spaces[t.bitmap.format], 'invalid source format')
		cinfo.input_components =
			assert(channel_count[t.bitmap.format], 'invalid source format')

		--set the default compression options based on in_color_space
		C.jpeg_set_defaults(cinfo)

		--set compression options
		if t.format then
			C.jpeg_set_colorspace(cinfo,
				assert(color_spaces[t.format], 'invalid destination format'))
		end
		if t.quality then
			C.jpeg_set_quality(cinfo, t.quality, true)
		end
		if t.progressive then
			C.jpeg_simple_progression(cinfo)
		end
		if t.dct_method then
			cinfo.dct_method =
				assert(dct_methods[t.dct_method], 'invalid dct_method')
		end
		if t.optimize_coding then
			cinfo.optimize_coding = t.optimize_coding
		end
		if t.smoothing then
			cinfo.smoothing_factor = t.smoothing
		end

		--start the compression cycle
		C.jpeg_start_compress(cinfo, true)

		--make row pointers from the bitmap buffer
		local bmp = t.bitmap
		local rows = rows_buffer(bmp.h, bmp.bottom_up, bmp.data, bmp.stride)

		--compress rows
		C.jpeg_write_scanlines(cinfo, rows, bmp.h)

		--finish the compression, optionally adding additional scans
		C.jpeg_finish_compress(cinfo)
	end)
end)

jit.off(save, true) --can't call error() from callbacks called from C

return {
	open = open,
	save = save,
	C = C,
}
