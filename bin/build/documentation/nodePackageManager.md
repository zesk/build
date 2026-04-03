## `nodePackageManager`

> Run an action using the current node package manager

### Usage

    nodePackageManager [ action ] ...

Run an action using the current node package manager
Provides an abstraction to libraries to support any node package manager.
Optionally will output the current node package manager when no arguments are passed.

### Arguments

- `action` - String. Optional. Action to perform: install run update uninstall
- `...` - Arguments. Required. Passed to the node package manager. Required. when action is provided.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

