## `jsonField`

> Fetch a non-blank field from a JSON file with error

### Usage

    jsonField [ --help ] handler jsonFile [ ... ]

Fetch a non-blank field from a JSON file with error handling

### Arguments

- `--help` - Flag. Optional. Display this help.
- `handler` - Function. Required. Error handler.
- `jsonFile` - File. Required. A JSON file to parse
- `...` - Arguments. Optional. Passed directly to jq

### Writes to standard output

selected field

### Writes to standard error

error messages

### Return codes

- `0` - Field was found and was non-blank
- `1` - Field was not found or is blank

