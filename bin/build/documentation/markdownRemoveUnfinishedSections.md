### `markdownRemoveUnfinishedSections`

> Given a file containing Markdown, remove header and any section

#### Arguments

- `--preprocess preprocessFunction` - Function. Optional. OneOrMore. A function to filter content via `stdin` prior to checking for tokens.
- `--help` - Flag. Optional. Display this help.

#### Examples

    markdownRemoveUnfinishedSections < inputFile > outputFile
    map.sh < $templateFile | markdownRemoveUnfinishedSections

#### Return codes

- 0

#### Environment

- None

