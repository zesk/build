# Git Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `veeGitTag`

If a tag in git is a version without a `v` prefix, this will rename it so that it has a `v` prefix and delete the old tag.

### Usage

    veeGitTag tagName

### Arguments

- `tagName` - The tag to vee

### Environment

Uses the local `git` project

### Examples

    veeGitTag 0.0.1

## `gitRemoveFileFromHistory` - Remove a file from the git history

If you have committed a secret to `git`, this is a way to undo your commit. Use with caution, and make a backup before using this. The has a lot of caveats particularly if a file has a long history.

This uses `git filter-branch` which has a lot of potential problems. Use with caution.

### Usage

    gitRemoveFileFromHistory fileName

### Arguments

- `fileName` is the path to the file to remove from git history


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)