# Documentation Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `bashFindFunctionDocumentation` - Generate a set of name/value pairs to document bash functions

Uses `bashFindFunctionDefinition` to locate bash function, then
extracts the comments preceding the function definition and converts it
into a set of name/value pairs.
A few special values are generated/computed:
- `description` - Any line in the comment which is not in variable is appended to the field `description`
- `fn` - The function name (no parenthesis or anything)
- `base` - The basename of the file
- `file` - The relative path name of the file from the application root
- `short_description` - Defaults to first ten words of `description`
- `exit_code` - Defaults to `0 - Always succeeds`
- `reviewed"  - Defaults to `Never`
- `environment"  - Defaults to `No environment dependencies or modifications.`
Otherwise the assumed variables (in addition to above) to define functions are:
- `argument` - Individual arguments
- `usage` - Canonical usage example (code)
- `example` - An example of usage (code, many)
- `depends` - Any dependencies (list)

### Usage

    bashFindFunctionDocumentation directory function

### Arguments

`directory` - Directory
`function` - Function to find definition for

### Exit codes

- `0` - Always succeeds

### Depends

    colors.sh text.sh prefixLines

## `bashFindFunctionDefinition` - Find where a function is defined in a directory of shell scripts

Finds a function definition and outputs the file in which it is found
Searches solely `.sh` files. (Bash or sh scripts)
Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

### Usage

    bashFindFunctionDefinition fnName0 [ fnName1... ]

### Arguments

`fnName0` - A function to find the file in which it is defined
`fnName1...` - Additional functions are found are output as well

### Examples

    bashFindFunctionDefinition bashFindFunctionDefinition
    ./bin/build/tools/autodoc.sh

### Exit codes

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

### Environment

Generates a temporary file which is removed

### Usage

    removeUnfinishedSections < inputFile > outputFile

### Arguments

- None

### Examples

    map.sh < $templateFile | removeUnfinishedSections

### Exit codes

- 0

### Environment

None

### Depends

    read printf

## `markdownListify` - Simple function to make list-like things more list-like in Markdown

Simple function to make list-like things more list-like in Markdown

### Exit codes

- `0` - Always succeeds

# `bashDocumentFunction`


### Usage

    bashDocumentFunction directory function template

### Arguments

`directory` - Directory to search for function definition
`function` - The function definition to search for and to map to the template
`template` - A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`

### Exit codes

- `1` - Template file not found
- `0` - Success

## `bashDocumentFunction` Formatting


## `_bashDocumentFunction_exit_codeFormat` - Format code blocks (does markdownListify)

Format code blocks (does markdownListify)

### Exit codes

- `0` - Always succeeds

## `_bashDocumentFunction_usageFormat` - Format usage blocks (indents as a code block)

Format usage blocks (indents as a code block)

### Exit codes

- `0` - Always succeeds

## `_bashDocumentFunction_exampleFormat` - Format example blocks (indents as a code block)

Format example blocks (indents as a code block)

### Exit codes

- `0` - Always succeeds

## `_bashDocumentFunction_argumentFormat` - Format argument blocks (does markdownListify)

Format argument blocks (does markdownListify)

### Exit codes

- `0` - Always succeeds

## `_bashDocumentFunction_dependsFormat` - Format depends blocks (indents as a code block)

Format depends blocks (indents as a code block)

### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)