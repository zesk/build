## `bashSimpleDocumentation`

> Output a simple error message for a function

### Usage

    bashSimpleDocumentation [ --help ] source function returnCode [ message ... ]

Output a simple error message for a function

### Arguments

- `--help` - Flag. Optional. Display this help.
- `source` - File. Required. File where documentation exists.
- `function` - String. Required. Function to document.
- `returnCode` - UnsignedInteger. Required. Exit code to return.
- `message ...` - String. Optional. Message to display to the user.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

bashFunctionComment decorate read printf returnCodeString __help bashDocumentation __bashDocumentationCached

