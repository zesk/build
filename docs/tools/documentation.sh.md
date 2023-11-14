# Documentation Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


## `bashFindFunctionDefinition` - Find where a function is defined in a directory of shell scripts


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

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

### Local cache

None

### Environment

Generates a temporary file which is removed

### Depends

    colors.sh text.sh prefixLines


### Usage

    bashDocumentFunction directory function template

### Arguments

`directory` - Directory to search for function definition
`function` - The function definition to search for and to map to the template
`template` - A markdown template to use to map values. Postprocessed with `removeUnfinishedSections`

### Examples

    bashFindFunctionDefinition bashFindFunctionDefinition
    ./bin/build/tools/autodoc.sh

### Exit codes

- `1` - Template file not found
- `0` - Success

### Local cache

None

### Environment

No environment dependencies or modifications.

### Depends

    colors.sh text.sh prefixLines

### Usage

    removeUnfinishedSections < inputFile > outputFile

### Arguments

None

### Examples

    map.sh < $templateFile | removeUnfinishedSections

### Exit codes

0

### Local cache

None

### Environment

None

### Depends

    read printf

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
