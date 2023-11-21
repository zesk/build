# Documentation Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

# `bashDocumentFunction`


### Usage

    bashDocumentFunction file function template

### Arguments

- `file` - Required. File in which the function is defined
- `function` - Required. The function name which is defined in `file`
- `template` - Required. A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`

### Exit codes

- `0` - Success
- `1` - Template file not found

## `documentFunctionsWithTemplate` - Convert a template into documentation for Bash functions

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
1. `functionTemplate` is used to generate the documentation for each function
1. Functions are looked up in `sourceCodeDirectory` and
1. Template used to generate documentation and compiled to `targetFile`

If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
to regenerate each time.

### Usage

    documentFunctionsWithTemplate sourceCodeDirectory documentTemplate functionTemplate targetFile [ cacheDirectory ]

### Arguments

- `sourceCodeDirectory` - Required. The directory where the source code lives
- `documentTemplate` - Required. The document template containing functions to define
- `templateFile` - Required. Function template file to generate documentation for functions
- `targetFile` - Required. Target file to generate
- `cacheDirectory` - Optional. If supplied, cache to reduce work when files remain unchanged.

### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

## `documentFunctionTemplateDirectory` - Convert a directory of templates into documentation for Bash functions

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. `documentDirectory` is scanned for files which look like `*.md`
1. `documentFunctionsWithTemplate` is called for each one

If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
to regenerate each time.

### Usage

    documentFunctionsWithTemplate sourceCodeDirectory documentDirectory functionTemplate targetDiretory [ cacheDirectory ]

### Arguments

- `sourceCodeDirectory` - Required. The directory where the source code lives
- `documentDirectory` - Required. Directory containing documentation templates
- `templateFile` - Required. Function template file to generate documentation for functions
- `targetDiretory` - Required. Directory to create generated documentation
- `cacheDirectory` - Optional. If supplied, cache to reduce work when files remain unchanged.

### Exit codes

- `0` - If success
- `1` - Any template file failed to generate for any reason
- `2` - Argument error

# Finding documentation


## `bashExtractDocumentation` - Generate a set of name/value pairs to document bash functions

Uses `bashFindFunctionFiles` to locate bash function, then
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

    bashExtractDocumentation directory function

### Arguments

`definitionFile` - File in which function is defined
`function` - Function defined in `file`

### Exit codes

- `0` - Always succeeds

### Depends

    colors.sh text.sh prefixLines

## `bashFindFunctionFiles` - Find where a function is defined in a directory of shell scripts

Finds one ore more function definition and outputs the file or files in which a
function definition is found. Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

### Usage

    bashFindFunctionFiles dirctory fnName0 [ fnName1... ]

### Arguments

`directory` - The directory to search
`fnName0` - A function to find the file in which it is defined
`fnName1...` - Additional functions are found are output as well

### Examples

    bashFindFunctionFiles . bashFindFunctionFiles
    ./bin/build/tools/autodoc.sh

### Exit codes

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

### Environment

Generates a temporary file which is removed

# Documentation Utilities


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

## `__dumpNameValue` - Utility to export multi-line values as Bash variables

Utility to export multi-line values as Bash variables

### Usage

    __dumpNameValue name [ value0 value1 ... ]

### Arguments

`name` - Shell value to output
`value0` - One or more lines of text associated with this value to be output in a - `bash` - friendly manner

### Exit codes

- `0` - Always succeeds

### Usage

    __dumpAliasedValue variable alias

### Arguments

`variable` - shell variable to set
`alias` - The shell variable to assign to `variable`

### Exit codes

- `0` - Always succeeds

# `bashDocumentFunction` Formatting


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