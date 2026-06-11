### `markdownRemoveUnfinishedSections`

> Remove markdown sections with tokens

#### Arguments

- `--preprocess preprocessFunction` - Function. Optional. OneOrMore. A function to filter content via `stdin` prior to checking for tokens.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--help` - Flag. Optional. Display this help.

#### Examples

    markdownRemoveUnfinishedSections --preprocess __removeRelLinks < inputFile > outputFile
    map.sh < "$templateFile" | markdownRemoveUnfinishedSections

#### Return codes

- 0

#### Environment

- None

