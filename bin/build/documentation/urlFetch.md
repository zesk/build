## `urlFetch`

> Fetch URL content

### Usage

    urlFetch [ --help ] [ --dump headerFile ] [ --header header ] [ --wget ] [ --redirect-max maxRedirections ] [ --curl ] [ --binary binaryName ] [ --argument-format format ] [ --user userName ] [ --password password ] [ --agent userAgent ] [ --timeout timeoutSeconds ] url [ file ]

Fetch URL content

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--dump headerFile` - String. Optional. Dump the headers to the file specified, specify `-` to output to `stdout`.
- `--header header` - String. Optional. Send a header in the format 'Name: Value'
- `--wget` - Flag. Optional. Force use of wget. If unavailable, fail.
- `--redirect-max maxRedirections` - PositiveInteger. Optional. Sets the number of allowed redirects from the original URL. Default is 9.
- `--curl` - Flag. Optional. Force use of curl. If unavailable, fail.
- `--binary binaryName` - Callable. Use this binary instead. If the base name of the file is not `curl` or `wget` you MUST supply `--argument-format`.
- `--argument-format format` - String. Optional. Supply `curl` or `wget` for parameter formatting.
- `--user userName` - String. Optional. If supplied, uses HTTP Simple authentication. Usually used with `--password`. Note: User names may not contain the character `:` when using `curl`.
- `--password password` - String. Optional. If supplied along with `--user`, uses HTTP Simple authentication.
- `--agent userAgent` - String. Optional. Specify the user agent string.
- `--timeout timeoutSeconds` - PositiveInteger. Optional. A number of seconds to wait before failing. Defaults to `BUILD_URL_TIMEOUT` environment value.
- `url` - URL. Required. URL to fetch to target file.
- `file` - FileDirectory. Optional. Target file. Use `-` to send to `stdout`. Default value is `-`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_URL_TIMEOUT.sh}

### Requires

returnMessage executableExists decorate
validate
throwArgument catchArgument
throwEnvironment catchEnvironment

