## `hookRun application-id`

> `application-id` hook default implementation

### Usage

    hookRun application-id [ --help ]

Generate a unique ID for the state of the application files
The default hook uses the short git sha:
    git rev-parse --short HEAD

### Arguments

- `--help` - Flag. Optional. Display this help.

### Examples

    885acc3

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

