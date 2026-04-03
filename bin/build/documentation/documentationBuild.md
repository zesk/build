## `documentationBuild`

> Build documentation for Bash functions

### Usage

    documentationBuild [ --git ] [ --commit ] [ --force ] [ --unlinked ] [ --unlinked-update ] [ --clean ] [ --help ] [ --company companyName ] [ --company-link companyLink ] [ --unlinked-source directory ] [ --page-template pageTemplateFile ] --source sourceDirectory --target targetDirectory [ --function-template functionTemplateFile ] [ --unlinked-template unlinkedTemplateFile ] [ --unlinked-target unlinkedTarget ] [ --see-prefix seePrefix ] [ --see-update ] [ --unlinked-update ] [ --index-update ] [ --docs-update ]

Build documentation for Bash functions
Given that bash is not an ideal template language, caching is mandatory.
Uses a cache at `buildCacheDirectory`

### Arguments

- `--git` - Flag. Optional. Merge current branch in with `docs` branch
- `--commit` - Flag. Optional. Commit docs to non-docs branch
- `--force` - Flag. Optional. Force generation, ignore cache directives
- `--unlinked` - Flag. Optional. Show unlinked functions
- `--unlinked-update` - Flag. Optional. Update unlinked document file
- `--clean` - Flag. Optional. Erase the cache before starting.
- `--help` - Flag. Optional. Display this help.
- `--company companyName` - String. Optional. Company name (uses `BUILD_COMPANY` if not set)
- `--company-link companyLink` - String. Optional. Company name (uses `BUILD_COMPANY_LINK` if not set)
- `--unlinked-source directory` - Directory. Optional.
- `--page-template pageTemplateFile` - File. Optional.
- `--source sourceDirectory` - Directory. Required. Location of source code. Can specify one or more.
- `--target targetDirectory` - Directory. Required. Location of documentation build target.
- `--function-template functionTemplateFile` - File. Optional.
- `--unlinked-template unlinkedTemplateFile` - File. Optional.
- `--unlinked-target unlinkedTarget` - FileDirectory. Optional.
- `--see-prefix seePrefix` - EmptyString. Optional.
- `--see-update` - Flag. Optional. Update the `see` indexes only.
- `--unlinked-update` - Flag. Optional. Update the unlinked file only.
- `--index-update` - Flag. Optional. Update the documentation indexes only.
- `--docs-update` - Flag. Optional. Update the documentation target only.

### Return codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error

