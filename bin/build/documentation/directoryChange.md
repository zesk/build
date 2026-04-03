## `directoryChange`

> Run a command after changing directory to it and then

### Usage

    directoryChange directory command [ ... ]

Run a command after changing directory to it and then returning to the previous directory afterwards.

### Arguments

- `directory` - Directory. Required. Directory to change to prior to running command.
- `command` - Callable. Required. Thing to do in this directory.
- `...` - Arguments. Optional. Arguments to `command`.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

pushd popd

