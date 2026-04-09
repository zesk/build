## `gitInsideHook`

> Are we currently inside a git hook?

### Usage

    gitInsideHook

Are we currently inside a git hook?
Tests non-blank strings in our environment.

### Arguments

- none

### Return codes

- `0` - We are, semantically, inside a git hook
- `1` - We are NOT, semantically, inside a git hook

### Environment

- GIT_EXEC_PATH - Must be set to pass
- GIT_INDEX_FILE - Must be set to pass

