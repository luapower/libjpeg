local libjpeg = require'libjpeg'
local glue = require'glue'

local function test_save()
	local infile = 'media/jpeg/progressive.jpg'
	local outfile = 'media/jpeg/temp.jpg'
	local bmp = libjpeg.load(infile)
	local jpg = libjpeg.save{bitmap = bmp}
	libjpeg.save{bitmap = bmp, path = outfile}
	assert(jpg == glue.readfile(outfile))
	assert(os.remove(outfile))
	print'ok'
end

test_save()

