## `gitCommit`

> Commits all files added to git and also update release

### Usage

    gitCommit [ --last ] [ -- ] [ --help ] [ comment ]

Commits all files added to git and also update release notes with comment
Comment wisely. Does not duplicate comments. Check your release notes.
Example:

### Arguments

- `--last` - Flag. Optional. Append last comment
- `--` - Flag. Optional. Skip updating release notes with comment.
- `--help` - Flag. Optional. I need somebody.
- `comment` - Text. Optional. A text comment for release notes and describing in general terms, what was done for a commit message.

### Examples

    c last
    c --last
    c --
... are all equivalent.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

