# URL Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `urlParse` - Simple Database URL Parsing

Simplistic URL parsing. Converts a `url` into values which can be parsed or evaluated:

- `url` - URL
- `host` - Database host
- `user` - Database user
- `password` - Database password
- `port` - Database port
- `name` - Database name

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

#### Usage

    urlParseItem url name

#### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection
- `name` - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`

#### Examples

consoleInfo "Connecting as $(urlParseItem "$url" user)"

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
