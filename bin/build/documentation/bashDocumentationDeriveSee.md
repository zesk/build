## `bashDocumentationDeriveSee`

> Generate SEE markdown content

### Usage

    bashDocumentationDeriveSee [ --help ] [ --check ] settingsFile

Generate `SEE/bashDocumentationDeriveSee.md` - Derived file generator.
File is next to `settingsFile`; `--check` checks to see if the file needs to be generated or updated.

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--check` - Flag. Optional. Check to see if an update is needed
- `settingsFile` - File. Required. Settings file for function to document.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

