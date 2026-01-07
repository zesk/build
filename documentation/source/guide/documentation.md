# Usage guide

[⬅ Return to top](../index.md)

**Usage** refers to the output that a command generates when an error occurs or the user (typically) uses the `--help`
argument
with the command. It shows _how to use_ the command.

e.g.

    ~/dev/build > identicalCheck
    [argument] Need to specify at least one --extension
    Usage: identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --token token ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ]
    
        --extension extension   Required. String. One or more extensions to search for in the current directory.
        --prefix prefix         Required. String. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)
        --exclude pattern       Optional. String. One or more patterns of paths to exclude. Similar to pattern used in find.
    ... continues

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
        catchEnvironment "$handler" curl -L "$bigFile" -o - > "$savedFile" || return $?
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
- `argumentType` is [a type](./types.md) such as `String`, `URL`, or `UnsignedInteger`
- `argumentRequirement` is `Required`, `Optional`, `OneOrMore`, `ZeroOrMore`
- `argumentDescription` is the brief description for the argument

### `Example:` - Example code

Any example code to display. This is rendered directly as Markdown, so indent code sections.

Format is:

    # Example: Here's a good example:
    # Example:
    # Example:     catchEnvironment "$handler" markdownCode || return $?

Where:

- `markdownCode` is rendered exactly (with the "`# Example: `" prefix removed).

### `Return Code:` - Exit codes

Describe the return codes for a function:

Format is:

    # Return Code: returnCode - returnCodeDescription

Where:

- `returnCode` is an integer or a return code string (see `returnCodeString`)
- `returnCodeDescription` is the brief description for the reason for any error

### `Environment:` - Environment variables used

List environment variables which are accessed by this function.

Format is:

    # Environment: environmentVariableName 

Where:

- `environmentVariableName` is the environment variable name. Pass one or more to be listed and linked to the definition
  in `bin/env/environmentVariableName.sh`
- Any text which does not match a known environment variable name is simply output on another line

### `stdout:` - Standard Output Description

If a function outputs something to `stdout` this describes the output format.

Format is:

    # stdout: stdoutType. Description

Where:

- `stdoutType` is a [standard data type](./types.md)

Where:

- `argumentFlag` can be the flag to designate the argument, like `--help`, or `--path`
- `argumentName` for arguments which take one or more values; the name of the argument expected.
- `...` for multiple
- `argumentType` is [a type](./types.md) such as `String`, `URL`, or `UnsignedInteger`
- `argumentRequirement` is `Required`, `Optional`, `OneOrMore`, `ZeroOrMore`
- `argumentDescription` is the brief description for the argument

### Usage using comments

Any name/value pair to be associated with a `function` but documentation generator requires access to the current file
to generate (as the code reads the script to extract the comment):

    #!/usr/bin/env bash

    set -eou pipefail

    # shellcheck source=/dev/null
    if source "$(dirname "${BASH_SOURCE[0]}")/../../bin/build/tools.sh"; then
      # Process a cool file
      # Argument: file - File. Required. The file to cool
      # Argument: directory - Directory. Required. The place to put the file
      # Argument: --help - Flag. Optional. Show this help and exit
      # Example:      myCoolScript my.cool ./coolOutput/
      myCoolScript() {
          local handler="_${FUNCNAME[0]}"
          file="${1-}"
          # ...
          [ -f "$file" ] || throwArgument "$handler" "Requires a file" || return $?
          # ...
      }
      _myCoolScript() {
         usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
      }
  
      myCoolScript "$@"
    fi

And the output:

    > ./docs/guide/example.sh
    Requires a file

    Usage: myCoolScript file directory [ --help ]

        file       Required. File. The file to cool
        directory  Required. Directory. The place to put the file
        --help     Show this help and exit

    Process a cool file

### Help handlers

Most functions handle help within their argument spinner which processes incoming arguments:

    case "$argument" in
    # _IDENTICAL_ helpHandler 1
        --help) "$handler" 0 && return $? || return $? ;;
    ...

To add `--help` support for simple functions, use the `__help` function:

    [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0

The above will add `myCoolScript --help` support for simple functions as well as error handling.

You can add arguments, return codes, summary lines, or even rename the function to something else in the documentation:

    # fn: makeCryptoThing
    # Process a cool file
    # Argument: file - File. Required. The file to cool
    # Argument: directory - Directory. Required. The place to put the file
    # Argument: --help - Flag. Optional. Show this help and exit
    # Example:      myCoolScript my.cool ./coolOutput/
    # Return Code: 0 - Success
    # Return Code: 1 - Environment error
    # Return Code: 2 - Argument error
    # stdout: Files cooled: 2000
    myCoolScript() {
        ...
    }

Similarly the same can be converted into our [amazing online documentation](/).

### Documentation Comment Variables and their meanings

The following variables are formatted and used in the `function help` via `usageDocument` as well as in the
documentation:

- `fn` - String. Optional. The function name if not specified
- `Argument` - Argument specifications, important. See `Argument Descriptions` above
- `Example` - An example of the function in use.
- `Return Code` - See `Return Code Descriptions` above
- `stdout` - The function produces `stdout` in this form
- `stdin` - The function reads `stdin` in this form
- `Environment` - See `Environment Descriptions` above
- `Credits` - Person to give credit to for some code in this function
- `Source` - URL of the person to give credit to.
- `Depends` - List of functions which this function depends on
- `See` - List of other functions which are related to this one
- `Output` - Sample output from this function
- `Usage` - The usage example line for this function showing arguments and their position
- `Description` - A description of the function
- `Summary` - A shorter summary of the function

The following are supported by the testing system:

- `Tag` - Tag tests with labels to filter easily
- `Test-Housekeeper` - `true` or `false` to enable/disable the `housekeeper` for a test
- `Test-Plumber` - `true` or `false` to enable/disable the `plumber` for a test
- `Test-Build-Home` - `true` or `false` to enable/disable the starting of tests in `BUILD_HOME`
- `Test-Platform` - Values to filter tests based on platform in the form `!alpine` `alpine` `!linux` `linux` or
  `!darwin` `darwin`
- `Test-Housekeeper-Overhead` - Show overhead of the housekeeper used in a function
- `Test-Fail` - This test should actually fail and not succeed to be considered passing
