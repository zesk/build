# Documentation Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Generating documentation


### `bashDocumentFunction` - Document a function and generate a function template (markdown)

Document a function and generate a function template (markdown)

#### Usage

    bashDocumentFunction file function template

#### Arguments

- `file` - Required. File in which the function is defined
- `function` - Required. The function name which is defined in `file`
- `template` - Required. A markdown template to use to map values. Post-processed with `markdown_removeUnfinishedSections`

#### Exit codes

- `0` - Success
- `1` - Template file not found

#### See Also

- [function bashDocumentationTemplate](./docs/tools/todo.md) - [Document a function and generate a function template (markdown). To](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh#L409)
- [function bashDocumentFunction](./docs/tools/documentation.md) - [Document a function and generate a function template (markdown)](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh#L375)
- [function repeat](./docs/tools/text.md) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L135)

### `documentationTemplateCompile` - Convert a template file to a documentation file using templates

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
1. `functionTemplate` is used to generate the documentation for each function
1. Functions are looked up in `cacheDirectory` using indexing functions and
1. Template used to generate documentation and compiled to `targetFile`

`cacheDirectory` is required - build an index using `documentationIndexIndex` prior to using this.

#### Arguments

- `cacheDirectory` - Required. Cache directory where the indexes live.
- `--env envFile` - Optional. File. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
- `documentTemplate` - Required. The document template containing functions to define
- `functionTemplate` - Required. The template for individual functions defined in the `documentTemplate`.
- `targetFile` - Required. Target file to generate

#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

#### See Also

- [function documentationIndex_Lookup](./docs/tools/documentation.md) - [Looks up information in the function index](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L34)
Not found

### `documentationTemplateDirectoryCompile` - Convert a directory of templates into documentation for Bash functions

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. `documentDirectory` is scanned for files which look like `*.md`
1. `documentationTemplateDirectoryCompile` is called for each one

If the `cacheDirectory` is supplied, it\'s used to store values and hashes of the various files to avoid having
to regenerate each time.

#### Arguments

- `cacheDirectory` - Required. The directory where function index exists and additional cache files can be stored.
- `documentDirectory` - Required. Directory containing documentation templates
- `templateFile` - Required. Function template file to generate documentation for functions
- `targetDirectory` - Required. Directory to create generated documentation

#### Exit codes

- `0` - If success
- `1` - Any template file failed to generate for any reason
- `2` - Argument error

#### See Also

- [function documentationTemplateCompile](./docs/tools/documentation.md) - [Convert a template file to a documentation file using templates](https://github.com/zesk/build/blob/main/bin/build/tools/documentation.sh#L94)

## Documentation Indexing


### `documentationIndex_Generate` - Generate a function index for bash files

Generate a function index for bash files

cacheDirectory/code/bashFilePath/functionName
cacheDirectory/index/functionName
cacheDirectory/files/baseName

Use with documentationIndex_Lookup

#### Arguments

- `codePath` - Required. Directory. Path where code is stored (should remain identical between invocations)
- `cacheDirectory` - Required. Directory. Store cached information

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function documentationIndex_Lookup](./docs/tools/documentation.md) - [Looks up information in the function index](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L34)

### `documentationIndex_Lookup` - Looks up information in the function index

Looks up information in the function index

#### Arguments

- `--settings` - `lookupPattern` is a function name. Outputs a file containing function settings
- `--source` - `lookupPattern` is a function name. Outputs the source code path to where the function is defined
- `--line` - `lookupPattern` is a function name. Outputs the source code line where the function is defined
- `--combined` - `lookupPattern` is a function name. Outputs the source code path and line where the function is defined as `path:line`
- `--file` - `lookupPattern` is a file name. Find files which match this base file name.
- `cacheDirectory` - Directory where we can store cached information
- `lookupPattern` - Token to look up in the index

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function documentationIndex_Generate](./docs/tools/documentation.md) - [Generate a function index for bash files](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L139)

# Linking documentation 


### `documentationIndex_LinkDocumentationPaths` - Update the documentationPath for all functions defined in documentTemplate

Update the documentationPath for all functions defined in documentTemplate

This updates

    cacheDirectory/index/functionName

and adds the `documentationPath` to it

Use with documentationIndex_Lookup

#### Arguments

- `cacheDirectory` - Required. Cache directory where the indexes live.
- `documentTemplate` - Required. The document template containing functions to index
- `documentationPath` - Required. The path to store as the documentation path.

#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

### `documentationIndex_SetUnlinkedDocumentationPath` - List of functions which are not linked to anywhere in

List of functions which are not linked to anywhere in the documentation index

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.
- `target` - Required. String. Path to document path where unlinked functions should link.

#### Exit codes

- `0` - Always succeeds

### `documentationIndex_ShowUnlinked` - Displays any functions which are not included in the documentation

Displays any functions which are not included in the documentation and the reason why.

- Any functions beginning with an **underscore** (`_`) are ignored
- Any function which contains ANY `ignore` directive in the comment is ignored
- Any function which is unlinked in the source (call `documentationIndex_LinkDocumentationPaths` first)

Within your function, add an ignore reason if you wish:

    userFunction() {
    ...
    }

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function documentationIndex_LinkDocumentationPaths](./docs/tools/documentation.md) - [Update the documentationPath for all functions defined in documentTemplate](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L419)
- [function documentationIndex_FunctionIterator](./docs/tools/documentation.md) - [Output a list of all functions in the index as](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L355)

### `documentationIndex_FunctionIterator` - Output a list of all functions in the index as

Output a list of all functions in the index as pairs:

    functionName functionSettings

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function documentationIndex_Lookup](./docs/tools/documentation.md) - [Looks up information in the function index](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L34)
- [function documentationIndex_LinkDocumentationPaths](./docs/tools/documentation.md) - [Update the documentationPath for all functions defined in documentTemplate](https://github.com/zesk/build/blob/main/bin/build/tools/documentation/index.sh#L419)

### `documentationIndex_UnlinkedIterator` - List of functions which are not linked to anywhere in

List of functions which are not linked to anywhere in the documentation index

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - The settings file is unlinked within the documentation (not defined anywhere)
- `1` - The settings file is linked within the documentation

### `documentationIndex_SeeLinker` - Link `Not found` tokens in documentation

$\Link `Not found` tokens in documentation

#### Exit codes

- `0` - Always succeeds

## Finding documentation


### `bashDocumentation_Extract` - Generate a set of name/value pairs to document bash functions

Uses `bashDocumentation_FindFunctionDefinitions` to locate bash function, then
extracts the comments preceding the function definition and converts it
into a set of name/value pairs.

A few special values are generated/computed:

- `description` - Any line in the comment which is not in variable is appended to the field `description`
- `fn` - The function name (no parenthesis or anything)
- `base` - The basename of the file
- `file` - The relative path name of the file from the application root
- `summary` - Defaults to first ten words of `description`
- `exit_code` - Defaults to `0 - Always succeeds`
- `reviewed"  - Defaults to `Never`
- `environment"  - Defaults to `No environment dependencies or modifications.`

Otherwise the assumed variables (in addition to above) to define functions are:

- `argument` - Individual arguments
- `usage` - Canonical usage example (code)
- `example` - An example of usage (code, many)
- `depends` - Any dependencies (list)

#### Arguments

- `definitionFile` - File in which function is defined
- `function` - Function defined in `file`

#### Exit codes

- `0` - Always succeeds

#### Depends

    colors.sh text.sh prefixLines

### `bashDocumentation_FindFunctionDefinitions` - Find where a function is defined in a directory of shell scripts

Finds one ore more function definition and outputs the file or files in which a
function definition is found. Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

#### Usage

    bashDocumentation_FindFunctionDefinitions directory fnName0 [ fnName1... ]

#### Arguments

- `directory` - The directory to search
- `fnName0` - A function to find the file in which it is defined
- `fnName1...` - Additional functions are found are output as well

#### Examples

bashDocumentation_FindFunctionDefinitions . bashDocumentation_FindFunctionDefinitions
    ./bin/build/tools/autodoc.sh

#### Exit codes

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

#### Environment

Generates a temporary file which is removed

## Usage Utilities


### `usageDocument` - Generates console usage output for a script using documentation tools

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and has it in one place for shell and online.

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ ... ]

#### Arguments

- `functionDefinitionFile` - Required. The file in which the function is defined. If you don\'t know, use `bashDocumentation_FindFunctionDefinitions` or `bashDocumentation_FindFunctionDefinition`.
- `functionName` - Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.

#### Examples

_documentationTemplateCompileUsage "$errorEnvironment" "Something is awry"

#### Exit codes

- `0` - Always succeeds

## Documentation Utilities


### `__dumpNameValue` - Utility to export multi-line values as Bash variables

Utility to export multi-line values as Bash variables

#### Usage

    __dumpNameValue name [ value0 value1 ... ]

#### Arguments

- `name` - Shell value to output
- `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner

#### Exit codes

- `0` - Always succeeds

#### Usage

    __dumpAliasedValue variable alias

#### Arguments

- `variable` - shell variable to set
- `alias` - The shell variable to assign to `variable`

#### Exit codes

- `0` - Always succeeds

## `bashDocumentFunction` Formatting


### `_bashDocumentationFormatter_exit_code` - Format code blocks (does markdown_FormatList)

Format code blocks (does markdown_FormatList)

#### Exit codes

- `0` - Always succeeds

### `_bashDocumentationFormatter_usage` - Format usage blocks (indents as a code block)

Format usage blocks (indents as a code block)

#### Exit codes

- `0` - Always succeeds

### `_bashDocumentationFormatter_argument` - Format argument blocks (does markdown_FormatList)

Format argument blocks (does markdown_FormatList)

#### Exit codes

- `0` - Always succeeds

### `_bashDocumentationFormatter_depends` - Format depends blocks (indents as a code block)

Format depends blocks (indents as a code block)

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
