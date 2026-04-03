## `jsonFileSet`

> Set or delete a value in a JSON file

### Usage

    jsonFileSet jsonFile path [ value ... ]

Set or delete a value in a JSON file

### Arguments

- `jsonFile` - File. Required. File to get value from.
- `path` - String. Required. dot-separated path to modify (e.g. `extra.fingerprint`)
- `value ...` - EmptyString. Optional. Value to set. If more than one value is set, value is set to an array value. If no value passed, the key is deleted. **Note the difference between a blank argument and NO argument.**

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

