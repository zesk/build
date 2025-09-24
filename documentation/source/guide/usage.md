# Usage guide

[⬅ Return to top](../index.md)

`Usage` is the output that a command generates when an error occurs or the user (typically) uses the `--help` argument
with the command.

e.g.

    > bin/build/identical-check.sh --help
    Need to specify at least one extension

    Usage: identical-check.sh --extension extension --prefix prefix [ --cd directory ] [ --help ]

        --extension extension  Required. One or more extensions to search for in the current directory.
        --prefix prefix        Required. A text prefix to search for to identify identical sections (e.g. `# IDENTICAL`) (may specify more than one)
        --cd directory         Optional. Change to this directory before running. Defaults to current directory.
        --help                 Optional. This help.
        etc.

If your terminal supports colors, then colors are used to make the help more readable.

## Usage basics

Most API functions define their `handler` (error handler) function which is the `function name` with a prefixed
underscore `_`.

When called it takes two arguments:

- `returnCode` - the return code of the failed command
- `message` - why the command failed

e.g.

    _myFunction 1 "Missing file $file"

The `returnCode` is required, and `0` is considered success.

- `handler` implementations SHOULD NEVER `exit`, instead it should return the passed in `returnCode`
- `message` - Is optional but highly recommended for all errors.

An example:

    myFunction() {
        local handler="_${FUNCNAME[0]}"
        local bigFile="$1" savedFile="$2"
        __catchEnvironment "$handler" curl -L "$bigFile" -o - > "$savedFile" || return $?
        ..
    }
    _myFunction() {
       usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Extensions to the basic `handler` model typically prefix additional parameters before the `returnCode`.

## Usage components

You define function usage by embedding comments directly above the function definition.

Usage for a command typically consists of the following components:

- Arguments to the command and their meanings and descriptions (`Argument:` line)
- An example handler (`Example:` lines)
- Any further description (`Description:` lines or any lines without a label)

## Usage labels

### `Argument:` - Function arguments

Workhorse for defining how a function should be called.

Format is:

    # Argument: [ argumentFlag ] [ argumentName ] [ ... ] [ -- ] - argumentType. argumentRequirement. argumentDescription

Where:

- `argumentFlag` can be the flag to designate the argument, like `--help`, or `--path`
- `argumentName` for arguments which take one or more values; the name of the argument expected.
- `...` for multiple
- `argumentType` is type such as `String`, `URL`, or `UnsignedInteger`
- `argumentRequirement` is `Required.` or `Optional.` or `One or more.` or `Zero or more.`
- `argumentDescription` is the brief description for the argument

### `Example:` - Example code

Any example code to display. This is rendered directly as Markdown, so indent code sections.

Format is:

    # Example: markdownCode

Where:

- `markdownCode` is rendered exactly (with the "`# Example: `" prefix removed).

### `Exit Code` - Exit codes

Describe the exit codes for a function:

Format is:

    # Return Code: exitCode - exitCodeDescription

Where:

- `returnCode` is an integer or a return code string (see `returnCode`)
- `returnCodeDescription` is the brief description for the reason for any error

### `Environment` - Environment variables used

List environment variables which are accessed by this function.

Format is:

    # Environment: environmentVariableName - environmentVariableDescription

Where:

- `environmentVariableName` is the environment variable name
- `environmentVariableDescription` is the brief description for how the function interacts with the environment variable

### Usage using comments

Any name/value pair to be associated with a `function` but documentation generator requires access to the current file
to generate (as the code reads the script to extract the comment):

    #!/usr/bin/env bash

    set -eou pipefail

    cd "$(dirname "${BASH_SOURCE[0]}")/../.."

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

    # Process a cool file
    # Argument: file - File. Required. The file to cool
    # Argument: directory - Directory. Required. The place to put the file
    # Argument: --help - Flag. Optional. Show this help and exit
    # Example:      myCoolScript my.cool ./coolOutput/
    myCoolScript() {
        local handler="_${FUNCNAME[0]}"
        file="${1-}"
        # ...
        [ -f "$file" ] || __throwArgument "$handler" "Requires a file" || return $?
        # ...
    }
    _myCoolScript() {
       usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

    myCoolScript "$@"

And the output:

    > ./docs/guide/example.sh
    Requires a file

    Usage: myCoolScript file directory [ --help ]

        file       Required. File. The file to cool
        directory  Required. Directory. The place to put the file
        --help     Show this help and exit

    Process a cool file

### Argument Descriptions

By default all argument descriptions should use the following pattern:

    Argument: argumentName - Optional. ArgumentType. Description 

With the following specification:

- `argumentName` - Name and one or more value names. May end with `...` if this argument can be repeated infinitely.
- `-` - The dash separates the name from the type and description.
- `Optional | Required`. Determines how many of an argument are required.
- If a description contains the term `Required` which matches any case, then arguments are assumed to be required.

[⬅ Return to top](../index.md)
