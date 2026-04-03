## `markdownFormatList`

> Simple function to make list-like things more list-like in Markdown

### Usage

    markdownFormatList

Simple function to make list-like things more list-like in Markdown
1. Remove all trailing spaces from all lines
2. remove leading "dash space" if it exists (`- `)
3. Semantically, if the phrase matches `[word]+[space][dash][space]`. backtick quote the `[word]`, otherwise skip
4. Prefix each line with a "dash space" (`- `)

### Arguments

- none

### Reads standard input

reads input from stdin

### Writes to standard output

formatted markdown list

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

