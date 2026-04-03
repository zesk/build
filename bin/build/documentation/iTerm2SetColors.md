## `iTerm2SetColors`

> Set terminal colors

### Usage

    iTerm2SetColors [ --verbose | -v ] [ --skip-errors ] [ --ignore | -i ] colorSetting ...

Set terminal colors
Color names permitted are:
- fg bg bold link selbg selfg curbg curfg underline tab
- black red green yellow blue magenta cyan white
- br_black br_red br_green br_yellow br_blue br_magenta br_cyan br_white
colorFormat is one of:
- `RGB` - Three hex [0-9A-F] values (hex3)
- `RRGGBB` - Six hex values (like CSS colors) (hex6)
- `cs:hex3` or `cs:hex6` - Where cs is one of `srgb`, `rgb`, or `p3`
Color spaces:
- `srgb` - The default color space
- 1rgb - Apple's device-independent colorspace
- `p3` - Apple's large-gamut colorspace
If no arguments are supplied which match a valid color setting values are read one-per-line from stdin.

### Arguments

--verbose |- ` -v` - Flag. Optional. Verbose mode. Show what you are doing.
- `--skip-errors - Flag. Optional. Skip errors in color settings and continue` - if loading a file containing a color scheme will load most of the file and skip any color settings with errors.
--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
- `colorSetting ...` - String. Required. colorName=colorFormat string

### Reads standard input

`colorName=colorFormat`. One per line. Only if no arguments passed with `colorSetting` format.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

