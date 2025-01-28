# Documentation Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Building documentation

### `documentationBuild` - Build documentation for Bash functions

Build documentation for Bash functions

Given that bash is not an ideal template language, caching is mandatory.

Uses a cache at `buildCacheDirectory`

- Location: `bin/build/tools/documentation/build.sh`

#### Arguments

- `--git` - Merge current branch in with `docs` branch
- `--commit` - Commit docs to non-docs branch
- `--force` - Force generation, ignore cache directives
- `--unlinked` - Show unlinked functions
- `--unlinked-update` - Update unlinked document file
- `--clean` - Erase the cache before starting.
- `--help` - I need somebody
- `--company companyName` - Optional. Company name (uses `BUILD_COMPANY` if not set)
- `--company-link companyLink` - Optional. Company name (uses `BUILD_COMPANY_LINK` if not set)

#### Exit codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error
### `documentationTemplateUpdate` - Map template files using our identical functionality

Map template files using our identical functionality

- Location: `bin/build/tools/documentation/template.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationTemplate` - Get an internal template name

Get an internal template name

- Location: `bin/build/tools/documentation/template.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationUnlinked` - List unlinked functions in documentation index

List unlinked functions in documentation index

- Location: `bin/build/tools/documentation/template.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Generating documentation

### `bashDocumentFunction` - Document a function and generate a function template (markdown)

Document a function and generate a function template (markdown)

- Location: `bin/build/tools/documentation.sh`

#### Usage

    bashDocumentFunction file function template
    

#### Arguments

- `file` - Required. File in which the function is defined
- `function` - Required. The function name which is defined in `file`
- `template` - Required. A markdown template to use to map values.

#### Exit codes

- `0` - Success
- `1` - Template file not found
### `documentationTemplateCompile` - Convert a template file to a documentation file using templates

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
1. `functionTemplate` is used to generate the documentation for each function
1. Functions are looked up in `cacheDirectory` using indexing functions and
1. Template used to generate documentation and compiled to `targetFile`

`cacheDirectory` is required - build an index using `documentationIndexIndex` prior to using this.

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--env-file envFile` - Optional. File. One (or more) environment files used to map `documentTemplate` prior to scanning, as defaults prior to each function generation, and after file generation.
- `cacheDirectory` - Required. Cache directory where the indexes live.
- `documentTemplate` - Required. The document template containing functions to define
- `functionTemplate` - Required. The template for individual functions defined in the `documentTemplate`.
- `targetFile` - Required. Target file to generate

#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error
### `documentationTemplateFunctionCompile` - Generate a function documentation block using `functionTemplate` for `functionName`

Requires function indexes to be generated in `cacheDirectory`.

Generate documentation for a single function.

Template is output to stdout.

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--env-file envFile` - Optional. File. One (or more) environment files used during map of `functionTemplate`
- `cacheDirectory` - Required. Cache directory where the indexes live.
- `functionName` - Required. The function name to document.
- `functionTemplate` - Required. The template for individual functions.

#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error
### `documentationTemplateDirectoryCompile` - Convert a directory of templates into documentation for Bash functions

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. `documentDirectory` is scanned for files which look like `*.md`
1. `documentationTemplateDirectoryCompile` is called for each one

If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
to regenerate each time.

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- `cacheDirectory` - Required. The directory where function index exists and additional cache files can be stored.
- `documentDirectory` - Required. Directory containing documentation templates
- `templateFile` - Required. Function template file to generate documentation for functions
- `targetDirectory` - Required. Directory to create generated documentation

#### Exit codes

- `0` - If success
- `1` - Any template file failed to generate for any reason
- `2` - Argument error

## Documentation Indexing

### `documentationIndex_Generate` - Generate a function index for bash files

Generate a function index for bash files

cacheDirectory/code/bashFilePath/functionName
cacheDirectory/index/functionName
cacheDirectory/files/baseName

Use with documentationIndex_Lookup

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `codePath` - Required. Directory. Path where code is stored (should remain identical between invocations)
- `cacheDirectory` - Required. Directory. Store cached information

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationIndex_Lookup` - Looks up information in the function index

Looks up information in the function index

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `--settings` - `lookupPattern` is a function name. Outputs a file containing function settings
- `--source` - `lookupPattern` is a function name. Outputs the source code path to where the function is defined
- `--line` - `lookupPattern` is a function name. Outputs the source code line where the function is defined
- `--combined` - `lookupPattern` is a function name. Outputs the source code path and line where the function is defined as `path:line`
- `--file` - `lookupPattern` is a file name. Find files which match this base file name.
- `cacheDirectory` - Directory where we can store cached information
- `lookupPattern` - Token to look up in the index

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

# Linking documentation 

### `documentationIndex_LinkDocumentationPaths` - Update the documentationPath for all functions defined in documentTemplate

Update the documentationPath for all functions defined in documentTemplate

This updates

    cacheDirectory/index/functionName

and adds the `documentationPath` to it

Use with documentationIndex_Lookup

- Location: `bin/build/tools/documentation/index.sh`

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

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.
- `target` - Required. String. Path to document path where unlinked functions should link.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationIndex_ShowUnlinked` - Displays any functions which are not included in the documentation

Displays any functions which are not included in the documentation and the reason why.

- Any functions beginning with an **underscore** (`_`) are ignored
- Any function which contains ANY `ignore` directive in the comment is ignored
- Any function which is unlinked in the source (call `documentationIndex_LinkDocumentationPaths` first)

Within your function, add an ignore reason if you wish:

    userFunction() {
    ...
    }

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationIndex_FunctionIterator` - Output a list of all functions in the index as

Output a list of all functions in the index as pairs:

    functionName functionSettings

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `documentationIndex_UnlinkedIterator` - List of functions which are not linked to anywhere in

List of functions which are not linked to anywhere in the documentation index

- Location: `bin/build/tools/documentation/index.sh`

#### Arguments

- `cacheDirectory` - Required. Directory. Index cache directory.

#### Exit codes

- `0` - The settings file is unlinked within the documentation (not defined anywhere)
- `1` - The settings file is linked within the documentation
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

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

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- `definitionFile` - File in which function is defined
- `function` - Function defined in `file`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bashDocumentation_FindFunctionDefinitions` - Find where a function is defined in a directory of shell scripts

Finds one ore more function definition and outputs the file or files in which a
function definition is found. Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

- Location: `bin/build/tools/documentation.sh`

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
### `bashDocumentation_FindFunctionDefinition` - Find single location where a function is defined in a directory of shell scripts

Finds a function definition and outputs the file in which it is found
Searches solely `.sh` files. (Bash or sh scripts)

Succeeds IFF only one version of a function is found.

- Location: `bin/build/tools/documentation.sh`

#### Usage

    bashDocumentation_FindFunctionDefinition directory fn
    

#### Arguments

- `directory` - The directory to search
- `fn` - A function to find the file in which it is defined

#### Examples

    bashDocumentation_FindFunctionDefinition . usage

#### Exit codes

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

#### Environment

Generates a temporary file which is removed

## Usage Utilities

### `usageDocument` - undocumented

No documentation for `usageDocument`.

- Location: `bin/build/install-bin-build.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Documentation Utilities

### `__dumpNameValue` - Utility to export multi-line values as Bash variables

Utility to export multi-line values as Bash variables

- Location: `bin/build/tools/documentation.sh`

#### Usage

    __dumpNameValue name [ value0 value1 ... ]
    

#### Arguments

- `name` - Shell value to output
- `value0` - One or more lines of text associated with this value to be output in a bash-friendly manner

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Usage

    __dumpAliasedValue variable alias
    

#### Arguments

- `variable` - shell variable to set
- `alias` - The shell variable to assign to `variable`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## `bashDocumentFunction` Formatting

### `_bashDocumentationFormatter_exit_code` - Format code blocks (does markdown_FormatList)

Format code blocks (does markdown_FormatList)

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_bashDocumentationFormatter_usage` - Format usage blocks (indents as a code block)

Format usage blocks (indents as a code block)

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_bashDocumentationFormatter_argument` - Format argument blocks (does markdown_FormatList)

Format argument blocks (does markdown_FormatList)

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `_bashDocumentationFormatter_depends` - Format depends blocks (indents as a code block)

Format depends blocks (indents as a code block)

- Location: `bin/build/tools/documentation.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
