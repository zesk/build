# Documentation Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Building documentation


### `documentationBuild` - Build documentation for Bash functions

Build documentation for Bash functions

Given that bash is not an ideal template language, caching is mandatory.

Uses a cache at `buildCacheDirectory`

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error

### `documentationTemplateUpdate` - Map template files using our identical functionality

Map template files using our identical functionality

#### Usage

    documentationTemplateUpdate templatePath repairPath
    

#### Exit codes

- `0` - Always succeeds

### `documentationTemplate` - Get an internal template name

Get an internal template name

#### Exit codes

- `0` - Always succeeds

### `documentationUnlinked` - List unlinked functions in documentation index

List unlinked functions in documentation index

#### Exit codes

- `0` - Always succeeds

## Generating documentation


### `bashDocumentFunction` - Document a function and generate a function template (markdown)

Document a function and generate a function template (markdown)

#### Usage

    bashDocumentFunction file function template
    

#### Arguments



#### Exit codes

- `0` - Success
- `1` - Template file not found

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `documentationTemplateCompile` - Convert a template file to a documentation file using templates

Convert a template which contains bash functions into full-fledged documentation.

The process:

1. `documentTemplate` is scanned for tokens which are assumed to represent Bash functions
1. `functionTemplate` is used to generate the documentation for each function
1. Functions are looked up in `cacheDirectory` using indexing functions and
1. Template used to generate documentation and compiled to `targetFile`

`cacheDirectory` is required - build an index using `documentationIndexIndex` prior to using this.

#### Usage

    documentationTemplateCompile [ --env envFile ] cacheDirectory documentTemplate functionTemplate templateFile targetFile
    

#### Arguments



#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
Not found

### `documentationTemplateDirectoryCompile` - Convert a directory of templates into documentation for Bash functions

Convert a directory of templates for bash functions into full-fledged documentation.

The process:

1. `documentDirectory` is scanned for files which look like `*.md`
1. `documentationTemplateDirectoryCompile` is called for each one

If the `cacheDirectory` is supplied, it's used to store values and hashes of the various files to avoid having
to regenerate each time.

#### Usage

    documentationTemplateDirectoryCompile cacheDirectory documentDirectory functionTemplate targetDirectory
    

#### Arguments



#### Exit codes

- `0` - If success
- `1` - Any template file failed to generate for any reason
- `2` - Argument error

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

## Documentation Indexing


### `documentationIndex_Generate` - Generate a function index for bash files

Generate a function index for bash files

cacheDirectory/code/bashFilePath/functionName
cacheDirectory/index/functionName
cacheDirectory/files/baseName

Use with documentationIndex_Lookup

#### Usage

    documentationIndex_Generate [ --clean ] codePath cacheDirectory
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `documentationIndex_Lookup` - Looks up information in the function index

Looks up information in the function index

#### Usage

    documentationIndex_Lookup [ --settings | --source | --line | --combined | --file ] cacheDirectory lookupPattern
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

# Linking documentation 


### `documentationIndex_LinkDocumentationPaths` - Update the documentationPath for all functions defined in documentTemplate

Update the documentationPath for all functions defined in documentTemplate

This updates

    cacheDirectory/index/functionName

and adds the `documentationPath` to it

Use with documentationIndex_Lookup

#### Usage

    documentationIndex_LinkDocumentationPaths cacheDirectory documentTemplate documentationPath
    

#### Arguments



#### Exit codes

- `0` - If success
- `1` - Issue with file generation
- `2` - Argument error

### `documentationIndex_SetUnlinkedDocumentationPath` - List of functions which are not linked to anywhere in

List of functions which are not linked to anywhere in the documentation index

#### Usage

    documentationIndex_SetUnlinkedDocumentationPath cacheDirectory target
    

#### Arguments



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

#### Usage

    documentationIndex_ShowUnlinked cacheDirectory
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `documentationIndex_FunctionIterator` - Output a list of all functions in the index as

Output a list of all functions in the index as pairs:

    functionName functionSettings

#### Usage

    documentationIndex_FunctionIterator cacheDirectory
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})
- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `documentationIndex_UnlinkedIterator` - List of functions which are not linked to anywhere in

List of functions which are not linked to anywhere in the documentation index

#### Usage

    documentationIndex_UnlinkedIterator cacheDirectory
    

#### Arguments



#### Exit codes

- `0` - The settings file is unlinked within the documentation (not defined anywhere)
- `1` - The settings file is linked within the documentation

### `documentationIndex_SeeLinker` - Link `Not found` tokens in documentation

$\Link `Not found` tokens in documentation

#### Usage

    documentationIndex_SeeLinker cacheDirectory documentationDirectory seeFunctionTemplate seeFunctionLink seeFileTemplate seeFileLink
    

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

#### Usage

    bashDocumentation_Extract definitionFile function
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `bashDocumentation_FindFunctionDefinitions` - Find where a function is defined in a directory of shell scripts

Finds one ore more function definition and outputs the file or files in which a
function definition is found. Searches solely `.sh` files. (Bash or sh scripts)

Note this function succeeds if it finds all occurrences of each function, but
may output partial results with a failure.

#### Usage

    bashDocumentation_FindFunctionDefinitions directory fnName0 [ fnName1... ]
    

#### Arguments



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

#### Usage

    bashDocumentation_FindFunctionDefinition directory fn
    

#### Arguments



#### Examples

    bashDocumentation_FindFunctionDefinition . usage

#### Exit codes

- `0` - if one or more function definitions are found
- `1` - if no function definitions are found

#### Environment

Generates a temporary file which is removed

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

## Usage Utilities


### `usageDocument` - Generates console usage output for a script using documentation tools

Generates console usage output for a script using documentation tools parsed from the comment of the function identified.

Simplifies documentation and has it in one place for shell and online.

#### Usage

    usageDocument functionDefinitionFile functionName exitCode [ ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

## Documentation Utilities


### `__dumpNameValue` - Utility to export multi-line values as Bash variables

Utility to export multi-line values as Bash variables

#### Usage

    __dumpNameValue name [ value0 value1 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    __dumpAliasedValue variable alias
    

#### Arguments



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
