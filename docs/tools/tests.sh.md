# Test Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## `testShellScripts`

Check all `.sh` files and make sure they pass bash linting as well as `shellcheck`.

All `.sh` files should have a Copyright with the current year.

If fails logs to standard output and returns a non-zero exit code.

## Usage

    testShellScripts

## Arguments

None.

## Exit codes

- Zero. Success.
- Non-zero. Failed.

## Local cache

No local caches.

## Environment

- Current directory is used to traverse shell scripts
- `shellcheck` is installed in the local environment if hasn't already

## Examples

    testShellScripts

## `assertEquals` - Description

Assert two strings are equal.

If this fails it will output an error and exit.

### Usage

    assertEquals expected actual [ message ]

### Arguments

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

None.

### Examples

    assertEquals "$(alignRight 4 "hi")" "  hi" "alignRight not working"

## `assertNotEquals` - Description

Assert two strings are not equal.

If this fails it will output an error and exit.

### Usage

    assertNotEquals expected actual [ message ]

### Arguments

- `expected` - Expected string
- `actual` - Actual string
- `message` - Message to output if the assertion fails

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

None.

### Examples

    assertNotEquals "$(head -1 /proc/1/sched | awk '{ print $1 })" "init" "sched should not be init"
## `assertExitCode` - Description

Assert a process runs and exits with the correct exit code.

If this fails it will output an error and exit.

### Usage

    assertExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

None.

### Examples

    assertExitCode 0 hasHook version-current

## `assertNotExitCode` - Description

Assert a process runs and exits with an exit code which does not match the passed in exit code.

If this fails it will output an error and exit.

### Usage

    assertNotExitCode expectedExitCode command [ arguments ... ]

### Arguments

- `expectedExitCode` - A numeric exit code not expected from the command
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

None.

### Examples

    assertNotExitCode 0 hasHook make-cash-quickly

## `assertOutputContains` - Description

Run a command and expect the output to contain the occurrence of a string.

If this fails it will output the installation log.

### Usage

    assertOutputContains expected command [ arguments ... ]

### Arguments

- `expected` - A string to expect in the output
- `command` - The command to run
- `arguments` - Any arguments to pass to the command to run

e.g.

    bin/build/---/-----.sh ./app/

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

- `BUILD_-----_VERSION` - String. Default to `latest`. Used to install the version of ----- you want on your environment.

### Examples

    foo.sh < thing > thang

## `randomString` - Description

TODO Update all of this including the long description.

If this fails it will output the installation log.

When this tool succeeds the `----` tool has been installed in the local environment.

### Usage

    foo.sh arg1 arg2 --help

### Arguments

- `--help` - This help

e.g.

    bin/build/---/-----.sh ./app/

### Exit codes

Zero.

### Local cache

No local caches.

### Environment

- `BUILD_-----_VERSION` - String. Default to `latest`. Used to install the version of ----- you want on your environment.

### Examples

    foo.sh < thing > thang


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

