# Sugar Extensions

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## Usage Sugar

See [Sugar Core](./sugar-core.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code handler command ...` - Run `command ...`, and if it fails invoke `handler` with `code` and command
  arguments.
- `__catchEnvironment handler command ...` - Run `command ...` and if it fails invoke `handler` with an environment
  error.
- `__catchArgument handler command ...` - Run `command ...` and if it fails invoke `handler` with an argument error.
- `__throwEnvironment handler message ...` - Run `handler` with an environment error and `message ...` arguments.
- `__throwArgument handler message ...` - Run `handler` with an argument error and `message ...` arguments.

`handler` argument signature is:

    `handler` `exitCode` `message ...`

This is universally used throughout.

## Usage Sugar References

{__execute}
{__catch}
{__catchCode}
{__catchEnvironment}
{__catchEnvironmentQuiet}

{__catchArgument}
{__throwEnvironment}
{__throwArgument}

{muzzle}
{mapReturn}
{convertValue}

## Deprecated Logging

{_deprecated}
