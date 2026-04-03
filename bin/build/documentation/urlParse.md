## `urlParse`

> Simple URL Parsing

### Usage

    urlParse [ --help ] [ url ] [ --prefix prefix ] [ --stringUppercase ]

Simple URL parsing. Converts a `url` into values which can be parsed or evaluated:
- `url` - URL
- `host` - Host
- `user` - User
- `password` - Password
- `port` - Connection port
- `name` - Path with the first slash removed
- `path` - Path
Does little to no validation of any characters so best used for well-formed input.
Now works on multiple URLs, output is separated by a blank line for new entries

### Arguments

- `--help` - Flag. Optional. Display this help.
- `url` - a Uniform Resource Locator
- `--prefix prefix` - String. Optional. Prefix variable names with this string.
- `--stringUppercase` - Flag. Optional. Output variable names in uppercase, not stringLowercase (the default).

### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

### Return codes

- `0` - If parsing succeeds
- `1` - If parsing fails

