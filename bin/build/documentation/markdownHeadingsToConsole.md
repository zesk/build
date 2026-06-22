### `markdownHeadingsToConsole`

> Convert Markdown Heading lines to console

#### Usage

    markdownHeadingsToConsole [ --help ] [ --handler handler ] [ --default defaultStyle ] [ --headings headingStyleList ]

Convert Markdown Heading lines to console

> Location: `bin/build/tools/colors.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--default defaultStyle` - String. Optional. Use this style on non-heading lines.
- `--headings headingStyleList` - ColonDelimitedList. Optional. Styles represent each heading depth with the first being `h1`, `h2, etc.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

