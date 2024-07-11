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


### `__usage` - Run `command`, handle failure with `usage` with `code` and `command`

Run `command`, handle failure with `usage` with `code` and `command` as error

#### Usage

    __usage code usage command ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Usage

    __usageEnvironment usage command
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    __usageArgument usage command
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    __failEnvironment usage message
    

#### Exit codes

- `0` - Always succeeds

#### Usage

    __failArgument usage message
    

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
