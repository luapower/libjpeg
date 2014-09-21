---
project: libjpeg
tagline: JPEG reader
---

## `local libjpeg = require'libjpeg'`

A ffi binding for [libjpeg-turbo], a fast and complete JPEG codec.

## Features

  * progressive loading
  * partial loading
  * fractional scaling
  * multiple pixel formats:
    * rgb8, bgr8, rgba8, bgra8, argb8, abgr8, \
		rgbx8, bgrx8, xrgb8, xbgr8, \
		g8, ga8, ag8, \
		ycc8, ycck8, cmyk8.


## `libjpeg.load(options_t | filename | read) -> image`

Read and decode a JPEG image. `options_t` is a table containing at least
the data source and possibly other options.

### 1. The image source:

  * `path`: read data from a file.
  * `string`: read data from a string.
  * `cdata`, `size`: read data from a buffer of specified size.
  * `stream`: read data from an opened `FILE *` stream.
  * `read`: read data from a reader function of the form:
		`read() -> cdata, size | string | nil`

### 2. Decoding and conversion options:

  * `accept.<pixel_format>: true/false` specify one or more accepted
pixel formats (see above).
  * `accept.top_down`: true/false (default is true)
  * `accept.bottom_up`: true/false
  * `accept.padded`: true/false (default is false) - specify that the row
stride should be a multiple of 4.
  * `scale_num`, `scale_denom`: scale down the image by the fraction
scale_num/scale_denom. Currently, the only supported scaling ratios are
M/8 with all M from 1 to 16, or any reduced fraction thereof
(such as 1/2, 3/4, etc.) Smaller scaling ratios permit significantly
faster decoding since fewer pixels need be processed and a simpler
IDCT method can be used.
  * `dct_method`: 'accurate', 'fast', 'float' (default is 'accurate')
  * `fancy_upsampling`: true/false (default is false); use a fancier upsampling
method.
  * `block_smoothing`: true/false (default is false); smooth out large pixels
of early progression stages for progressive JPEGs.
  * `partial_loading`: true/false (default is true); display broken images
partially or break with an error.
  * `header_only`: do not decode the image; return only the image header fields.
  * `render_scan`: a function to be called as
  `render_scan(image, is_last_scan, scan_number)` for each progressive scan
  of a multi-scan JPEG. It can used to implement progressive display of images.
    * also called once for single-scan images.
    * also called on error, as `render_scan(nil, true, scan_number, error)`,
    where `scan_number` is the scan number that was supposed to be rendering
    next and `error` the error message.
  * `warning`: a function to be called as `warning(msg, level)` on non-fatal errors.

> __NOTE__: Not all conversions are possible with libjpeg-turbo,
so always check the image's `format` field to get the actual format.
Use [bitmap] to further convert the image if necessary.

For more info on the decoding process and options read the [libjpeg-turbo doc].

### 3. The returned image:

  * `file`: a table describing file attributes:
	  * `w`, `h`, `format`, `progressive`, `jfif`, `adobe`.
	  * note: `format` is missing for unknown formats.
  * `format`, `bottom_up`, `stride`, `data`, `size`, `w`, `h`: output image
  format, dimensions and pixel data.
	  * the number of bits per channel is always 8.
	  * these fields are not present with the `headers_only` option.
  * `partial`: true if the image was found to be truncated and it was
  partially loaded.


## `libjpeg.save(options_t) -> string | chunks_t | nil`

Save a [bitmap] as JPEG. `options_t` is a table containing at least
the source bitmap and destination, and possibly other options.

### 1. The source bitmap:

  * `bitmap`: a [bitmap] in an accepted format (see above).

### 2. The output:

  * `path`: write data to a file.
  * `stream`: write data to an opened `FILE *` stream.
  * `chunks`: append data chunks to a list (which is also returned).
  * `write`: write data to a sink of the form:
		`write(buf, size)`
  * `finish`: optional function to be called after all the data is written.

If no output option is specified, the jpeg binary is returned as a Lua string.

### 3. Encoding options:

  * `format`: output format (see list of supported formats above).
  * `quality`: 0..100 range. you know what that is.
  * `progressive`: true/false (default is false). make it progressive.
  * `dct_method`: 'accurate', 'fast', 'float' (default is 'accurate').
  * `optimize_coding`: optimize huffmann tables.
  * `smoothing`: 0..100 range. smoothing factor.


## Limitations

  * loading one scan line at a time (easy).
  * saving one scan line at a time (easy).
  * jit is turned off because we can't call error() from a ffi callback
  called from C; and yet libjpeg says that we must not return control to
  C on errors, and the only way to do that is to call error().
  * the read callback cannot yield since it is called from C code.
  This means that reading data with coroutine-based socket schedulers
  is not an option. Is there a way around it that doesn't involve threads?


----
See also: [nanojpeg](nanojpeg.html)


[libjpeg-turbo]:      http://www.libjpeg-turbo.org/
[libjpeg-turbo doc]:  http://sourceforge.net/p/libjpeg-turbo/code/HEAD/tree/trunk/libjpeg.txt
