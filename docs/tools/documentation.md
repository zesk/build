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


## Generating documentation






## Documentation Indexing




# Linking documentation 








## Finding documentation





## Usage Utilities



## Documentation Utilities




## `bashDocumentFunction` Formatting





