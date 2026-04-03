## `gitInstallHook`

> Install the most recent version of this hook and RUN

### Usage

    gitInstallHook [ --application ] [ --copy ] [ hook ] [ --help ]

Install the most recent version of this hook and RUN IT in place if it has changed.
You should ONLY run this from within your hook, or provide the `--copy` flag to just copy.
When running within your hook, pass additional arguments so they can be preserved:
    gitInstallHook --application "$myHome" pre-commit "$@" || return $?

### Arguments

- `--application` - Directory. Optional. Path to application home.
- `--copy` - Flag. Optional. Do not execute the hook if it has changed.
- `hook` - A hook to install. Maps to `git-hook` internally. Will be executed in-place if it has changed from the original.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - the file was not updated
- `1` - Environment error
- `2` - Argument error

### Environment

- BUILD-HOME - The default application home directory used for `.git` and build hooks.

