
# Web Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `urlMatchesLocalFileSize` - Compare a remote file size with a local file size

Compare a remote file size with a local file size

#### Arguments

- `url` - Required. URL. URL to check.
- `file` - Required. File. File to compare.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `urlContentLength` - Get the size of a remote URL

Get the size of a remote URL

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Depends

    curl
     
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error 
### `hostTTFB` - Fetch Time to First Byte and other stats

Fetch Time to First Byte and other stats

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `websiteScrape` - Uses wget to fetch a site, convert it to HTML

Uses wget to fetch a site, convert it to HTML nad rewrite it for local consumption
SIte is stored in a directory called `host` for the URL requested

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
