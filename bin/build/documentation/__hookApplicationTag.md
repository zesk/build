## `hookRun application-tag`

> `application-tag` hook default implementation

### Usage

    hookRun application-tag

Get the "tag" (or current display version) for an application
The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.

### Arguments

- none

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

