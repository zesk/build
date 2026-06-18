### `booleanParse`

> Parses text and determines if it's true-ish

#### Usage

    booleanParse

Parses text and determines if it's true-ish

Without arguments, displays help.

> Location: `bin/build/tools/text.sh`

#### Arguments

- none

#### Return codes

- `0` - true
- `1` - false
- `2` - Neither
- `0` - Text is plain
- `1` - Text contains non-plain characters

#### Requires

- [stringLowercase]({rel}tools/text.md#stringlowercase) - Convert text to stringLowercase ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L864))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))

