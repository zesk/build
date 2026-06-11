### `urlParseItem`

> Get a URL component directly

#### Usage

    urlParseItem [ component ] url ...

Extract a component from one or more URLs.
Component names are the same as returned by the base `urlParse` function:
- `url`
- `url`
- `path`
- `name`
- `scheme`
- `user`
- `password`
- `host`
- `port`
- `portDefault`
- `error`
The component `error` changes the behavior of the function – the function succeeds and returns the error string even if the URL is invalid. This
permits the retrieval of the error message without any additional formatting if needed.

> Location: `bin/build/tools/url.sh`

#### Arguments

- `component` - the url component to get: `url`, `path`, `name`, `scheme`, `user`, `password`, `host`, `port`, `portDefault`, `error`
- `url ...` - String. URL. Required. A Uniform Resource Locator used to specify a database connection

#### Examples

    decorate info "Connecting as $(urlParseItem user "$url")"

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

