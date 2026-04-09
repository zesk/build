## `gitInstallHooks`

> Install one or more git hooks from Zesk Build hooks.

### Usage

    gitInstallHooks [ --copy ] [ --verbose ] [ --application home ] [ hookName ] [ --help ]

Install one or more git hooks from Zesk Build hooks.
Zesk Build hooks are named `git-hookName.sh` in `bin/hooks/` so `git-pre-commit.sh` will be installed as the `pre-commit` hook for git.
Hook types:
- `pre-commit`
- `pre-push`
- `pre-merge-commit`
- `pre-rebase`
- `pre-receive`
- `update`
- `post-update`
- `post-commit`

### Arguments

- `--copy` - Flag. Optional. Copy the hook but do not execute it.
- `--verbose` - Flag. Optional. Be verbose about what is done.
- `--application home` - Directory. Optional. Set the application home directory to this prior to looking for hooks.
- `hookName` - String. Optional. A hook or hook names to install. See `gitHookTypes`
- `--help` - Flag. Optional. Display this help.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

