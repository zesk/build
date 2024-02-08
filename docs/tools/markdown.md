# Markdown Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


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

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
