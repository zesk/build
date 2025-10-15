# Sugar Extensions

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Top ](../index.md)
<hr />

## Usage Sugar

See [Sugar Core](./sugar-core.md) first.

This groupings of functions are related to a `usage` function to handle errors:

- `__usage code handler command ...` - Run `command ...`, and if it fails invoke `handler` with `code` and command
  arguments.
- `catchEnvironment handler command ...` - Run `command ...` and if it fails invoke `handler` with an environment
  error.
- `catchArgument handler command ...` - Run `command ...` and if it fails invoke `handler` with an argument error.
- `throwEnvironment handler message ...` - Run `handler` with an environment error and `message ...` arguments.
- `throwArgument handler message ...` - Run `handler` with an argument error and `message ...` arguments.

`handler` argument signature is:

    `handler` `exitCode` `message ...`

This is universally used throughout.

## Usage Sugar References

{execute}
{catchReturn}
{catchCode}
{catchEnvironment}
{catchEnvironmentQuiet}

{catchArgument}
{throwEnvironment}
{throwArgument}

{muzzle}
{mapReturn}
{convertValue}

## Handling arguments and stdin similarly

{executeInputSupport}

## Deprecated Logging

{_deprecated}
