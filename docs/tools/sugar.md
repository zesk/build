# Sugar Extensions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## Usage Sugar

See [Sugar Core](_sugar.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code usageFunction command ...` - Run `command ...`, and if it fails invoke `usageFunction` with `code` and command arguments.
- `__usageEnvironment usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an environment error.
- `__usageArgument usageFunction command ...` - Run `command ...` and if it fails invoke `usageFunction` with an argument error.
- `__failEnvironment usageFunction message ...` - Run `usageFunction` with an environment error and `message ...` arguments.
- `__failArgument usageFunction message ...` - Run `usageFunction` with an argument error and `message ...` arguments.

## Usage Sugar References


### `__usage` - Run `command` and usage with `code` by running `usage`

Run `command` and usage with `code` by running `usage`

#### Usage

    __usage code usage command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `__usageEnvironment` - Run `command`, upon failure run `usage` with an environment error

Run `command`, upon failure run `usage` with an environment error

#### Usage

    __usageEnvironment usage command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `__usageArgument` - Run `command`, upon failure run `usage` with an argument error

Run `command`, upon failure run `usage` with an argument error

#### Usage

    __usageArgument usage command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

### `__failEnvironment` - Run `usage` with an environment error

Run `usage` with an environment error

#### Usage

    __failEnvironment usage ...
    

#### Exit codes

- `0` - Always succeeds

### `__failArgument` - Run `usage` with an argument error

Run `usage` with an argument error

#### Usage

    __failArgument usage ...
    

#### Exit codes

- `0` - Always succeeds

## Deprecated Logging


### `_deprecated` - Logs all deprecated functions to application root in a file

Logs all deprecated functions to application root in a file called `.deprecated`

#### Usage

    _deprecated command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
