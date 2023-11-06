# Assert Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

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


## `assertDirectoryExists` - Test that a directory exists

### Usage

    assertDirectoryExists directory [ message ... ]

### Arguments

- `directory` - Directory that should exist
- `message` - An error message if this fails

### Exit codes

- `1` - If the assertion fails

### Local cache

No local caches.

### Environment

- This fails if `directory` is anything but a `directory`

### Examples

    assertDirectoryExists "$HOME" "HOME not found"

## `assertDirectoryDoesNotExist` - Test that a directory does not exist

### Usage

    assertDirectoryDoesNotExist directory [ message ... ]

### Arguments

- `directory` - Directory that should NOT exist
- `message` - An error message if this fails

### Exit codes

- `1` - If the assertion fails

### Local cache

No local caches.

### Environment

- This fails if `directory` is anything at all, even a non-directory (such as a link)

### Examples

    assertDirectoryDoesNotExists "$INSTALL_PATH" "INSTALL_PATH should not exist yet"

## `assertFileContains` - Assert file contains one or more strings

### Usage

    assertFileContains fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must be found on at least one line in the file

### Exit codes

- `1` - If the function fails

### Local cache

No local caches.

### Environment

If the file does not exist, this will fail.

### Examples

    assertFileContains $logFile Success
    assertFileContains $logFile "is up to date"


## `assertFileDoesNotContain` - Assert file does not contain one or more strings

### Usage

    assertFileDoesNotContain fileName string0 [ ... ]

### Arguments

- `fileName` - File to search
- `string0 ...` - One or more strings which must NOT be found anywhere in `fileName`

### Exit codes

- `1` - If the function fails

### Local cache

No local caches.

### Environment

If the file does not exist, this will fail.

### Examples

    assertFileDoesNotContain $logFile error Error ERROR
    assertFileDoesNotContain $logFile warning Warning WARNING

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
