# Markdown Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

#### Usage

    markdown_removeUnfinishedSections < inputFile > outputFile
    

#### Arguments

- None

#### Examples

    map.sh < $templateFile | markdown_removeUnfinishedSections

#### Exit codes

- 0

#### Environment

None

#### Depends

    read printf
    
### `markdown_FormatList` - Simple function to make list-like things more list-like in Markdown

Simple function to make list-like things more list-like in Markdown

1. remove leading "dash space" if it exists (`- `)
2. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
3. Prefix each line with a "dash space" (`- `)

- Location: `bin/build/tools/markdown.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
