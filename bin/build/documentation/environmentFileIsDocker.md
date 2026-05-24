## `environmentFileIsDocker`

> Ensure an environment file is compatible with non-quoted docker environment

### Usage

    environmentFileIsDocker [ filename ]

Ensure an environment file is compatible with non-quoted docker environment files

> Location: `bin/build/tools/environment/convert.sh`

### Arguments

- `filename` - Docker environment file to check for common issues

### Return codes

- `1` - if errors occur
- `0` - if file is valid

