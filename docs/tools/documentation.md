# Documentation Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Building documentation


### `documentationTemplateUpdate` - Map template files using our identical functionality

Map template files using our identical functionality

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

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Finding documentation


### `bashDocumentation_FindFunctionDefinitions` - Find where a function is defined in a directory of shell scripts

Finds one ore more function definition and outputs the file or files in which a
function definition is found. Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

- Location: `bin/build/tools/documentation.sh`

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


#### Arguments

- `variable` - shell variable to set
- `alias` - The shell variable to assign to `variable`

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## `bashDocumentFunction` Formatting


### `_bashDocumentationFormatter_usage` - Format usage blocks (indents as a code block)

Format usage blocks (indents as a code block)

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
