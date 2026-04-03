## `deployApplicationVersion`

> Extracts version from an application either from `.deploy` files or

### Usage

    deployApplicationVersion applicationHome

Extracts version from an application either from `.deploy` files or from the the `.env` if
that does not exist.
Checks `APPLICATION_ID` and `APPLICATION_TAG` and uses first non-blank value.

### Arguments

- `applicationHome` - Directory. Required. Application home to get the version from.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

