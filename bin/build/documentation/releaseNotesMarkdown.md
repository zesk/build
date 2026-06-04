### `releaseNotesMarkdown`

> Generate markdown for release notes

#### Usage

    releaseNotesMarkdown [ --count fullCount ] [ --title titleText ] [ --rel rel ] [ --help ] [ --handler handler ]

Outputs full release notes, a separator (title), and then a list to all remaining release notes in markdown.
Output show release notes in reverse version order:
- the catenation of the release notes files (`count` items)
- a blank line
- the title line and a blank line (or nothing if title line is blank)
- list links to remaining release notes (`- [v0.0.1](./0.0.1.md)` for example)

> Location: `bin/build/tools/version.sh`

#### Arguments

- `--count fullCount` - PositiveInteger. Number of recent release notes to include in the output. Defaults to 5.
- `--title titleText` - EmptyString. Markdown text to display between the recent release notes and the links to release notes.
- `--rel rel` - EmptyString. Relative link text to display before links. Defaults to `.`
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

#### Writes to standard output

markdown

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

