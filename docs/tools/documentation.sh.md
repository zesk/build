# Documentation Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `bashFindFunctionDefinition` - 

Finds a function definition and outputs the file in which it is found
Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

(Located at: `./bin/build/tools/documentation.sh`)

### Usage

    bashFindFunctionDefinition fnName0 [ fnName1... ]

### Arguments

`fnName0` - A function to find the file in which it is defined
`fnName1...` - Additional functions are found are output as well

### Examples

    bashFindFunctionDefinition bashFindFunctionDefinition
    ./bin/build/tools/autodoc.sh

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

## `bashFindFunctionDocumentation` - 

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

(Located at: `./bin/build/tools/documentation.sh`)

### Usage

    bashFindFunctionDocumentation directory function

### Arguments

`directory` - Directory
`function` - Function to find definition for

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Depends

    colors.sh text.sh prefixLines

### Usage

    bashDocumentFunction directory function template

### Arguments

`directory` - Directory to search for function definition
`function` - The function definition to search for and to map to the template
`template` - A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Usage

    removeUnfinishedSections < inputFile > outputFile

### Arguments

None

### Examples

    map.sh < $templateFile | removeUnfinishedSections

### Exit codes

- `0` - Always succeeds

### Local cache

None

### Environment

No environment dependencies or modifications.

### Depends

    read printf

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
