# Usage guide

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

**Usage** refers to the output that a command generates when an error occurs or the user (typically) uses the `--help`
argument with the command. It shows _how to use_ the command.

e.g.

    ~/dev/build > identicalCheck
    ❌ [argument] Need to specify at least one --extension
    Usage: identicalCheck --extension extension --prefix prefix [ --exclude pattern ] [ --cd directory ] [ --repair directory ] [ --skip file ] [ --ignore-singles ] [ --no-map ] [ --debug ] [ --help ] [ --singles singlesFiles ] [ --single singleToken ] [ --token token ] [ token ... ]
    
        --extension extension   String. Required. One or more extensions to search for in the current directory.
        --prefix prefix         String. Required. A text prefix to search for to identify identical sections (e.g. # IDENTICAL) (may specify more than one)
        --exclude pattern       String. Optional. One or more patterns of paths to exclude. Similar to pattern used in find.
        --cd directory          Directory. Optional. Change to this directory before running. Defaults to current directory.

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

- `handler` implementations SHOULD **NEVER** `exit`, instead it should **ALWAYS** return the passed in `returnCode`
- `message` - Is optional but highly recommended for all errors.

An example:

    myFunction() {
        local handler="_${FUNCNAME[0]}"
        local bigFile="$1" savedFile="$2"
        catchEnvironment "$handler" curl -L "$bigFile" -o - > "$savedFile" || return $?
        ..
    }
    _myFunction() {
       bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Extensions to the basic `handler` model typically prefix additional parameters before the `returnCode`.

## Usage components

You define function's usage by embedding comments directly above the function definition.

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

Any example code to display. This is rendered directly as Markdown, so indent code sections with `five` spaces. (`one`
for the label, `four` for markdown)

Format is:

    # Example: markdownCode ...

Example:

    # Example: Here's a good example:
    # Example:
    # Example:     catchEnvironment "$handler" exampleThing || return $?

Where:

- `markdownCode` - EmptyString. Optional. The code is rendered exactly (with the "`# Example: `" prefix removed).

### `Return Code:` - Return codes

Describe the return codes for a function:

Format is:

    # Return Code: returnCode - returnCodeDescription

Where:

- `returnCode` - UnsignedInteger. Required. is an integer or a return code string (see `returnCodeString`)
- `returnCodeDescription` - String. Optional. is the brief description for the reason for any error

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

    # stdout: stdoutType. stdoutDescription

Where:

- `stdoutType` - String. Optional. Supply a [standard data type](./types.md)
- `stdoutDescription`. EmptyString. Optional. Description of the output.

### `stdin:` - Standard Input Description

If a function reads from `stdin` this describes the input format.

Format is:

    # stdin: stdinType. stdinDescription

Where:

- `stdinType` - String. Optional. Supply a [standard data type](./types.md)
- `stdinDescription`. EmptyString. Optional. Description of the output.

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
         bashDocumentation "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
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

To add `--help` support for simple functions, use the `helpArgument` function:

    [ $# -eq 0 ] || helpArgument --only "_${FUNCNAME[0]}" "$@" || return 0

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

The following variables are formatted and used in the `function help` via `bashDocumentation` as well as in the
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
- `Requires` - List of functions which this function depends on
- `See` - List of other functions which are related to this one (and useful to know about)
- `Output` - Sample output from this function
- `Usage` - The usage example line for this function showing arguments and their position (deprecated - now generated
  from `Argument:`s)
- `Description` - A description of the function
- `Summary` - A shorter summary of the function

### Teating-related variables for functions

The following are supported by the testing system - you place these on the test function itself, not the target
function:

So, for example, if our test was `./test/tools/my-tests.sh`, our test function can be annotated:

    # Test that function so hard 
    # Tag: slow myFunction apiTests
    # Test-Housekeeper: false
    # Test-Plumber: true
    testMyFunction() {
      ...
    }

### No effect on test results if enabled (or disabled)

- `Tag` - `SpaceDelimitedList`. Tag tests with labels to filter easily and run only certain tests.
- `Test-Housekeeper-Overhead` - `Boolean`. Show overhead of the housekeeper used in a function (for enabled tests)

### These may change test results if enabled (or disabled)

- `Test-Housekeeper` - `Boolean`. `true` or `false` to enable/disable the `housekeeper` for a test. The `housekeeper`
  monitors the
  temporary directory and the test directory and the project directory to ensure no files are left behind.
- `Test-Plumber` - `Boolean`. `true` or `false` to enable/disable the `plumber` for a test. The `plumber` monitors the
  called
  function to ensure it does not leak `local` or environment variables.
- `Test-Build-Home` - `Boolean`. `true` or `false` to enable/disable the starting of tests in `BUILD_HOME` (starts in a
  sandbox
  directory instead) - useful to determine if tests depend on the current directory being the project home directory or
  *not*.
- `Test-Platform` - `SpaceDelimitedList`. Values to filter tests based on platform in the form `!alpine` `alpine`
  `!linux` `linux` or
  `!darwin` `darwin`
- `Test-Fail` - `Boolean`. Set to `true` if *this test should actually fail* and **not succeed** to be considered *
  *passing** - useful to test the testing system or failure conditions.

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
