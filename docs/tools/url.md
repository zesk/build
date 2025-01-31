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

Now works on multiple URLs, output is separated by a blank line for new entries

- Location: `bin/build/tools/url.sh`

#### Arguments

- `url` - a Uniform Resource Locator used to specify a database connection

#### Examples

    eval "$(urlParse scheme://user:password@host:port/path)"
    echo $name

#### Exit codes

- `0` - If parsing succeeds
- `1` - If parsing fails
### `urlParseItem` - Get a database URL component directly

Gets the component of one or more URLs

- Location: `bin/build/tools/url.sh`

#### Arguments

- `url0` - String. URL. Required. A Uniform Resource Locator used to specify a database connection
- `component` - the url component to get: `name`, `user`, `password`, `host`, `port`, `failed`

#### Examples

    decorate info "Connecting as $(urlParseItem user "$url")"

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
### `urlOpen` - Open a URL using the operating system

Open a URL using the operating system
Usage urlOpen [ --help ]

- Location: `bin/build/tools/url.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--ignore` - Optional. Flag. Ignore any invalid URLs found.
- `--wait` - Optional. Flag. Display this help.
- `--url url` - Optional. URL. URL to download.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `urlOpener` - Open URLs which appear in a stream (but continue to

Open URLs which appear in a stream (but continue to output the stream)

- Location: `bin/build/tools/url.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `urlFilter` - Open URLs which appear in a stream

Open URLs which appear in a stream
URLs are explicitly trimmed at quote, whitespace and escape boundaries.

- Location: `bin/build/tools/url.sh`

#### Arguments

- `--show-file` - Boolean. Optional. Show the file name in the output (suffix with `: `)
- `--file name - String. Optional. The file name to display` - can be any text.
- `file` - File. Optional. A file to read and output URLs found.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `urlFetch` - undocumented

No documentation for `urlFetch`.

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.
- `--header header` - String. Optional. Send a header in the format 'Name: Value'
- `--wget` - Flag. Optional. Force use of wget. If unavailable, fail.
- `--curl` - Flag. Optional. Force use of curl. If unavailable, fail.
- `--binary binaryName` - Callable. Use this binary instead. If the base name of the file is not `curl` or `wget` you MUST supply `--argument-format`.
- `--argument-format format` - Optional. String. Supply `curl` or `wget` for parameter formatting.
- `--user userName` - Optional. String. If supplied, uses HTTP Simple authentication. Usually used with `--password`. Note: User names may not contain the character `:` when using `curl`.
- `--password password` - Optional. String. If supplied along with `--user`, uses HTTP Simple authentication.
- `url` - Required. URL. URL to fetch to target file.
- `file` - Required. FileDirectory. Target file.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
