---
tagline: JPEG encoding & decoding
---

## `local jpeg = require'libjpeg'`

A ffi binding for the [libjpeg][libjpeg-home] 6.2 API.
Supports progressive loading, yielding from the reader function,
partial loading, fractional scaling and multiple pixel formats.
Comes with [libjpeg-turbo] binaries.

## API

------------------------------------------------- -------------------------------------------------
`jpeg.open(t|read) -> jpg|nil,err`                open a JPEG file and read it's header
`jpg.w`                                           width
`jpg.h`                                           height
`jpg.format`                                      pixel format
`jpg.progressive`                                 has multiple scans
`jpg:accepts(fmt) -> true|false`                  check if pixel format is accepted for output
`jpg:accepts({fmt -> true}) -> {fmt -> true}`     check which pixel formats are accepted for output
`jpg:dimensions(fmt|t) -> w, h, stride`           output dimensions for decompression options
`jpg:load(bmp[, x, y]) -> bmp | nil,err`          load/paint the pixels into a given [bitmap]
`jpg:load(format, ...) -> bmp | nil,err`          load the pixels into a new bitmap
`jpg:rows(bmp | format,...) -> iter() -> i, bmp`  iterate the rows over a 1-row bitmap
`jpg:load(t) -> bmp|nil,err`                      load the pixels into a [bitmap]
`jpg:free()`                                      free the jpeg object
`jpeg.save(bmp, write) -> ok|nil,err`             save a [bitmap] using a write function
------------------------------------------------- -------------------------------------------------

### `libjpeg.open(t|read) -> image`

Open a JPEG file using a `read(buf, size) -> readsize` function to get
the bytes. The read function should accept any size >= 0 and it should
raise an error if it can't read all the bytes, except on EOF when it
should return 0.

If given instead, `t` is a table containing:

  * `read` (required): the read function.
  * `partial_loading` (true): display broken images partially or return an error.
  * `suspended_io` (true): allow yielding from the read function.
    note that arithmetic decoding doesn't work with suspended I/O
    (browsers don't support arithmetic decoding either).
  * `read_buffer_size`: the size of the read buffer.
  * `read_buffer`: read buffer to use.
  * `warning`: a function to be called as `warning(msg, level)` on non-fatal errors.

### `jpg:accepts({fmt -> true} | fmt) -> fmt|nil`

Given a table of accepted pixel formats, return the best format that the image
can be loaded into, if any. Possible formats: rgb8, bgr8, rgba8, bgra8,
argb8, abgr8, rgbx8, bgrx8, xrgb8, xbgr8, g8, ga8, ag8, ycc8, ycck8, cmyk8.

### `jpg:dimensions(t) -> w, h, stride`

Return output image dimensions for a certain set of decompression options:

  * `format`, `stride_aligned`, `stride`: bitmap format and/or stride.
  * `scale_num`, `scale_denom`: scale down the image by the fraction
    scale_num/scale_denom. Currently, the only supported scaling ratios are
    M/8 with all M from 1 to 16, or any reduced fraction thereof
    (such as 1/2, 3/4, etc.). Smaller scaling ratios permit significantly
    faster decoding since fewer pixels need be processed and a simpler
    IDCT method can be used.
  * `dct_method`: 'accurate' (default), 'fast', 'float'
  * `fancy_upsampling` (false): use a fancier upsampling method.
  * `block_smoothing` (false): smooth out large pixels of early progression
    stages for progressive JPEGs.

### `jpg:bitmap(t) -> bmp`

Make a bitmap for a certain set of decompression options. Options can be
all the options above plus:

  * `h`: bitmap height.
  * `alloc`: custom `alloc(size) -> buf` function.

### `jpg:decode([scan_num, ]t)`

Load and decode (a scan of) the image into a compatible bitmap. Options
can be all the options above plus:

### `jpg:more() -> status | nil`

Load data in advance of decoding and return on scan and row boundaries.
Status can be 'start_scan'`, 'end_scan', 'end_row' or nil for EOF.

* any of the options that the `dimensions()` function accepts.
  * `render_scan`: a function to be called as
    `render_scan(image, is_last_scan, scan_number)`; called once if the image
	 is single-scan; called once for each progressive scan if the image is
	 multi-scan.

For more info on the decoding process and options read the [libjpeg-turbo doc].

#### 3. The return value:

The return value is a [bitmap] with extra fields:

  * `file`: a table describing the source file, with the following attributes:
	  * `w`, `h`, `format`, `progressive`, `jfif`, `adobe`.
  * `partial`: true if the image was found to be truncated and it was
  partially loaded.

NOTE:

  * the number of bits per channel in the output bitmap is always 8.
  * the bitmap fields are not present with the `header_only` option.
  * unknown JPEG formats are loaded but the `format` field is missing.


### `libjpeg.save(options_t) -> string | chunks_t | nil`

Save a [bitmap] as JPEG. `options_t` is a table containing at least
the source bitmap and destination, and possibly other options.

#### 1. The source bitmap:

  * `bitmap`: a [bitmap] in an accepted format (see above).

#### 2. The output:

  * `path`: write data to a file.
  * `stream`: write data to an opened `FILE *` stream.
  * `chunks`: append data chunks to a list (which is also returned).
  * `write`: write data to a sink of the form:
		`write(buf, size)`
  * `finish`: optional function to be called after all the data is written.

If no output option is specified, the jpeg binary is returned as a Lua string.

#### 3. Encoding options:

  * `format`: output format (see list of supported formats above).
  * `quality`: 0..100 range. you know what that is.
  * `progressive`: true/false (default is false). make it progressive.
  * `dct_method`: 'accurate', 'fast', 'float' (default is 'accurate').
  * `optimize_coding`: optimize huffmann tables.
  * `smoothing`: 0..100 range. smoothing factor.
  * `bufsize`: internal buffer size (default is 4096).


----
See also: [nanojpeg]

[libjpeg-home]:       http://libjpeg.sourceforge.net/
[libjpeg-turbo]:      http://www.libjpeg-turbo.org/
[libjpeg-turbo doc]:  http://sourceforge.net/p/libjpeg-turbo/code/HEAD/tree/trunk/libjpeg.txt
