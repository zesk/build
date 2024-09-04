# URL Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `urlParse` - Simple Database URL Parsing

Simplistic URL parsing. Converts a `url` into values which can be parsed or evaluated:

- `url` - URL
- `host` - Database host
- `user` - Database user
- `password` - Database password
- `port` - Database port
- `name` - Database name

Does little to no validation of any characters so best used for well-formed input.

- Location: `bin/build/tools/url.sh`

#### Usage

    urlParse url
    

#### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection

#### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

#### Exit codes

- `0` - If parsing succeeds
- `1` - If parsing fails
### `urlParseItem` - Get a database URL component directly

Gets the component of the URL from a given database URL.

- Location: `bin/build/tools/url.sh`

#### Usage

    urlParseItem component url0 [ url1 ... ]
    

#### Arguments

- `url0` - String. URL. Required. A Uniform Resource Locator used to specify a database connection
- `component` - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`

#### Examples

    consoleInfo "Connecting as $(urlParseItem user "$url")"

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `urlValid` - Checks a URL is valid

Checks a URL is valid

- Location: `bin/build/tools/url.sh`

#### Arguments

- `url ...` - String. URL. Required. A Uniform Resource Locator

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
