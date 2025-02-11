# Interactive Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## File pipelines

### `interactiveManager` - Run checks interactively until errors are all fixed.

Run checks interactively until errors are all fixed.
Not ready for prime time yet - written not tested.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `verificationCallable` - Required. Callable. Call this on each file and a zero result code means passed and non-zero means fails.
- `--exec binary` - Optional. Callable. Run binary with files as an argument for any failed files. Only works if you pass in item names.
- `--delay delaySeconds` - Optional. Integer. Delay in seconds between checks in interactive mode.
- `fileToCheck ...` - Optional. File. Shell file to validate. May also supply file names via stdin.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## User prompts

### `interactiveCountdown` - undocumented

No documentation for `interactiveCountdown`.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### `confirmYesNo` - undocumented

No documentation for `confirmYesNo`.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error ### `pause` - Pause for user input

Pause for user input

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Copy files

### `copyFileWouldChange` - Check whether copying a file would change it

Check whether copying a file would change it
This function does not modify the source or destination.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Something would change
- `1` - Nothing would change ### `copyFile` - Copy file from source to destination

Copy file from source to destination

Supports mapping the file using the current environment, or escalated privileges.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `--escalate` - Flag. Optional. The file is a privilege escalation and needs visual confirmation. Requires root privileges.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Success
- `1` - Failed

## Load bash files but get approval first

### `interactiveBashSource` - Loads files or a directory of `.sh` files using `source`

Loads files or a directory of `.sh` files using `source` to make the code available.
Has security implications. Use with caution and ensure your directory is protected.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `directoryOrFile` - Required. Exists. Directory or file to `source` `.sh` files found.
- `--info` - Optional. Flag. Show user what they should do (press a key).
- `--no-info` - Optional. Flag. Hide user info (what they should do ... press a key)
- `--verbose` - Optional. Flag. Show what is done as status messages.
- `--clear` - Optional. Flag. Clear the approval status for file given.
- `--prefix` - Optional. String. Display this text before each status messages.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "$"; then
        __environment copyFile "$" || return $?
        __environment service ssh restart || return $?
    fi
