## `muzzle`

> Suppress stdout without piping. Handy when you just want a

### Usage

    muzzle command [ ... ]

Suppress stdout without piping. Handy when you just want a behavior not the output.

### Arguments

- `command` - Callable. Required. Thing to muzzle.
- `...` - Arguments. Optional. Additional arguments.

### Writes to standard output

- No output from stdout ever from this function

### Examples

    muzzle pushd "$buildDir"
    catchEnvironment "$handler" phpBuild || returnUndo $? muzzle popd || return $?

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

