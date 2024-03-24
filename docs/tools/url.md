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

Does little to no validation of any characters so best used for well-formed input.

#### Usage

    urlParse url
    

#### Arguments



#### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

#### Exit codes

- `0` - If parsing succeeds
- `1` - If parsing fails

### `urlParseItem` - Get a database URL component directly

Gets the component of the URL from a given database URL.

#### Usage

    urlParseItem component url0 [ url1 ... ]
    

#### Arguments



#### Examples

    consoleInfo "Connecting as $(urlParseItem user "$url")"

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
