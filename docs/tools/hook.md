# Hooks

Hooks are called to enable custom actions at specific times which can be overwritten or intercepted by the application.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

# Hook Running

### `hookRun` - Run a project hook

Run a hook in the project located at `./bin/hooks/`

See (Hooks documentation)[../hooks/index.md] for standard hooks.

Hooks provide an easy way to customize your build. Hooks are binary files located in your project directory at `./bin/hooks/` and are named `hookName` with a `.sh` extension added.
So the hook for `version-current` would be a file at:

    bin/hooks/version-current.sh

Sample hooks (scripts) can be found in the build source code at `./bin/hooks/`.

Default hooks (scripts) can be found in the current build version at `bin/build/hooks/`

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `hookName` - String. Required. Hook name to run.
- `arguments` - Optional. Arguments are passed to `hookName`.
- `--help` - Optional. Flag. Display this help.

#### Examples

    version="$(hookRun version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### Environment

BUILD_HOOK_PATH
### `hookRunOptional` - Identical to `hookRun` but returns exit code zero if the

Identical to `hookRun` but returns exit code zero if the hook does not exist.

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home.
- `hookName` - String. Required. Hook name to run.
- `arguments` - Optional. Arguments are passed to `hookName`.
- `--help` - Optional. Flag. Display this help.

#### Examples

    version="$(hookRunOptional version-current)"

#### Exit codes

- `Any` - The hook exit code is returned if it is run
- `1` - is returned if the hook is not found

#### Environment

BUILD_HOOK_PATH
### `whichHook` - Find the path to a hook binary file

Does a hook exist in the local project?

Find the path to a hook. The search path is:

- `./bin/hooks/`
- `./bin/build/hooks/`

If a file named `hookName` with the extension `.sh` is found which is executable, it is output.

- Location: `bin/build/tools/hook.sh`

#### Arguments

- `--application applicationHome` - Path. Optional. Directory of alternate application home. Can be specified more than once to change state.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

See [Defined Hooks](hooks.md)
