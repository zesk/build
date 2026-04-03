## `jsonSetValue`

> Sets the value of a variable in a JSON file

### Usage

    jsonSetValue [ --filter ] [ --status ] [ --quiet ] [ --generator ] [ --value ] [ --key ] key file

Sets the value of a variable in a JSON file

### Arguments

- `--filter` - Function. Optional. Run value through this filter prior to inserting into the JSON file.
- `--status` - Flag. Optional. When set, returns `0` when the value was updated successfully and `$(returnCode identical)` when the values is the same
- `--quiet` - Flag. Optional. Do not output anything to `stdout` and just do the action and exit.
- `--generator` - Function. Optional. Function to generate the value. Defaults to `hookVersionCurrent`.
- `--value` - String. Optional. Value to set in JSON file. (Skips generation)
- `--key` - String. Optional. Key to set in JSON file. Defaults to `version`.
- `key` - Required. If not specified as `--key`, specify it here.
- `file` - File. Required. Modify and update this file

### Return codes

- `0` - File was updated successfully.
- `1` - Environment error
- `2` - Argument error
- `105` - Identical files (only when --status is passed)

