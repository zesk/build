## `iTerm2Image`

> Output an image to the console

### Usage

    iTerm2Image [ --width width ] [ --height height ] [ --preserve-aspect-ratio ] [ --scale ] [ --ignore | -i ]

Output an image to the console

### Arguments

- `--width width` - PositiveInteger. Width in columns to display image.
- `--height height` - PositiveInteger. Height in rows to display image.
- `--preserve-aspect-ratio` - Flag. Preserve the aspect ratio.
- `--scale` - Flag. Do not preserve the aspect ratio, scale the image.
--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

### Writes to standard output

No output, however, if in an iTerm2 terminal it will display an image in the console at the cursor position

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

