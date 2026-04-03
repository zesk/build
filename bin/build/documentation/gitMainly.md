## `gitMainly`

> Merge `staging` and `main` branches of a git repository into

### Usage

    gitMainly

Merge `staging` and `main` branches of a git repository into the current branch.
Will merge `origin/staging` and `origin/main` after doing a `--pull` for both of them
Current repository should be clean and have no modified files.

### Arguments

- none

### Return codes

- `1` - Already in main, staging, or HEAD, or git merge failed
- `0` - git merge succeeded

