## `urlParseItem`

> Get a URL component directly

### Usage

    urlParseItem [ component ] url ...

Extract a component from one or more URLs

### Arguments

- `component` - the url component to get: `url`, `path`, `name`, `scheme`, `user`, `password`, `host`, `port`, `portDefault`, `error`
- `url ...` - String. URL. Required. A Uniform Resource Locator used to specify a database connection

### Examples

    decorate info "Connecting as $(urlParseItem user "$url")"

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

