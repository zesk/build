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

### `confirmYesNo` - Read user input and return 0 if the user says

Read user input and return 0 if the user says yes

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `defaultValue` - Boolean. Optional. Value to return if no value given by user
- `--yes` - Boolean. Optional. Short for `--default yes`
- `--no` - Boolean. Optional. Short for `--default no`

#### Exit codes

- `0` - Yes
- `1` - No ### `pause` - Pause for user input

Pause for user input

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Copy files

### `copyFileWouldChange` - undocumented

No documentation for `copyFileWouldChange`.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Something would change
- `1` - Nothing would change ### `copyFile` - undocumented

No documentation for `copyFile`.

- Location: `bin/build/tools/interactive.sh`

#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `--escalate` - Flag. Optional. The file is a privilege escalation and needs visual confirmation.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Success
- `1` - Failed

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "$"; then
        __environment copyFile "$" || return $?
        __environment service ssh restart || return $?
    fi
