### `urlOpen`

> Opens the default browser for a URL on the host operating system

#### Usage

    urlOpen [ --help ] [ --ignore ] [ --wait ] [ --url url ]

Open a URL using the operating system.
Uses the operating system's `open` functionality to open URLs. On Linux uses `xdg-open` or `kde-open`.

> Note: Tested only on Mac OS X.

> Location: `bin/build/tools/url.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.
- `--ignore` - Flag. Optional. Ignore any invalid URLs found.
- `--wait` - Flag. When multiple URLs are passed, make a single `open` call with all URLs as command line arguments after all URLs are validated; otherwise each URL is opened individually with the system's `open` call.
- `--url url` - URL. Optional. URL to open.

#### Reads standard input

line - URL. Optional. URL to open

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_URL_BINARY` URL Executable]({rel}env/#decoration) – **Callable**. Binary used in __urlOpen

