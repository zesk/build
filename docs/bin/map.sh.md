
## Usage

    map.sh [ environmentName0 environmentName1 ... ]
    mapEnvironment [ environmentName0 environmentName1 ... ]

## Arguments

- `environmentName0` - Map this value only. If not specified, all environment variables are mapped.

## Exit codes

- `0` - Always succeeds

## Environment

Argument-passed or entire environment variables which are exported are used and mapped to the destination.

## See Also

mapValue