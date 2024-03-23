# Sugar Core

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

Sugar refers to syntactic sugar - code which makes other code more readable.

The functions are grouped as follows;

- `_` - Single underscore prefixed functions means "return" a failure value
- `__` - Double underscore prefixed functions means "run the command" and handle the failure value

Quick guide:

- `_exit message ...` - Exits with exit code 99 always. Outputs `message ...` to `stderr`. If `BUILD_DEBUG` environment is set to `true` will output debugging information. Should be used for script initialization which is critical, otherwise avoid it and use `_return`.
- `_return code message ...` - Return code always. Outputs `message ...` to `stderr`.
- `_environment message ...` - Return `$errorEnvironment` always. Outputs `message ...` to `stderr`.
- `_argument message ...` - Return `$errorArgument` always. Outputs `message ...` to `stderr`.
- `__execute command ...` - Run `command ...` (with any arguments) and then `_return` if it fails.
- `__try command ...` - Run `command ...` (with any arguments) and then `_exit` if it fails. Critical code only.
- `__echo command ...` - Output the `command ...` to stdout prior to running, then `__execute` it
- `__environment command ...` - Run `command ...` (with any arguments) and then `_environment` if it fails.
- `__argument command ...` - Run `command ...` (with any arguments) and then `_argument` if it fails.

# Sugar Functions References

{_exit}
{_return}
{_environment}
{_argument}
{__execute}
{__try}
{__echo}
{__environment}
{__argument}

## Decorations

{_list}


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

Copyright &copy; {year} [{BUILD_COMPANY}]({BUILD_COMPANY_LINK}{title})
