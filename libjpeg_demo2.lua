local ffi = require'ffi'
local nw = require'nw'
local thread = require'thread'
local bitmap = require'bitmap'
local glue = require'glue'

local function threadfunc(url, bmpq, bmpmutex)
	local ok, err = pcall(function()

	local ffi = require'ffi'
	local jpeg = require'libjpeg'
	local glue = require'glue'
	local curl = require'libcurl'

	local function bmp_serialize(bmp)
		local bmps = glue.update({}, bmp)
		bmps.data = glue.addr(bmp.data)
		return bmps
	end

	local jpeg_thread = coroutine.wrap(function()
		local t = {}
		function t.read_more(...)
			return coroutine.yield('read_more', ...)
		end
		function t.read(...)
			return coroutine.yield('read', ...)
		end
		local jpg = assert(jpeg.open(t))
		local bmp = jpg:bitmap'bgra8'
		bmpq:push(bmp_serialize(bmp))
		repeat
			assert(jpg:start_output(bmp))
			local output_scan = jpg:output_scan()
			while assert(jpg:next_row()) do
				bmpq:push(bmp_serialize(bmp))
			end
			assert(jpg:finish_output())
		until jpg:complete() and jpg:input_scan() == output_scan
	end)

	local ret
	local cmd, buf, sz = jpeg_thread()

	local function write(buf, sz)
		local function pass(cmd, ...)
		if cmd == 'read' then
			local dbuf, dsz = ...
			local csz = math.min(sz, dsz)
			ffi.copy(dbuf, buf, csz)
			sz = sz - csz
			return csz
		elseif cmd == 'read_more' then
			return sz > 0
		end
		while sz > 0 do
			ret = pass(jpeg_thread(ret))
		end
	end

	local etr = curl.easy(url)
	local total_size = 0
	local total_chunks = 0
	etr:set('writefunction', function(buf, sz)
		write(buf, sz)
		total_size = total_size + sz
		return sz
	end)
	local mtr = curl.multi()
	mtr:add(etr)
	while assert(mtr:perform()) > 0 do
		mtr:wait()
		total_chunks = total_chunks + 1
	end
	mtr:close()
	etr:close()
	print('chunks: ', total_chunks)
	print('size:   ', total_size, math.floor(total_size / total_chunks))

	end)
	if not ok then print(err) end
end

local url = 'http://www.planwallpaper.com/static/images/2ba7dbaa96e79e4c81dd7808706d2bb7_large.jpg'
local bmpq = thread.queue()
local imgthread = thread.new(threadfunc, url, bmpq)

local app = nw:app()

local win = app:window{
	w = 800, h = 500,
	visible = false,
}

local function bmp_deserialize(bmps)
	local bmp = glue.update({}, bmps)
	bmp.data = glue.ptr(bmp.data)
	return bmp
end

function win:repaint()
	local bmp = win:bitmap()
	if bmpq:length() > 0 then
		local jbmp = bmp_deserialize(bmpq:pop())
		bitmap.paint(jbmp, bmp, 10, 10)
	end
end

app:runevery(0.2, function()
	if bmpq:length() > 0 then
		win:repaint()
	end
end)

win:show()

app:run()

imgthread:join()
