### Usage

    __hookProjectActivate [ otherHomeDirectory ]

The `project-activate` hook runs when this project is activated in the console (and another project was previously active)
Implementations MUST overwrite environment variables which MUST change here or MUST be active here to work, etc.
This is NOT like other hooks in that it is run as `hookSource`

### Arguments

- `otherHomeDirectory` - The old home directory of the project

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `approve` - Report on all approvals during project activation
- `approve-verbose` - Display verbose approval messages

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

