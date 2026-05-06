## `bashDocumentationDeriveFunction`

> Generate markdown documentation page

### Usage

    bashDocumentationDeriveFunction [ --help ] [ --check ] settingsFile

Generate function derived files.

File(s) are generated next to `settingsFile`.

- `--check` checks to see if the file needs to be generated or updated. Returns 0 if up to date.

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--check` - Flag. Optional. Check to see if an update is needed
- `settingsFile` - File. Required. Settings file for function to document.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

