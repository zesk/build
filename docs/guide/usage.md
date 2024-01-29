# Usage guide

[⬅ Return to top](../index.md)

Usage is the output that a command generates when an error occurs or the user (typically) uses the `--help` argument with the command.

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

The `usage` function in your own function in any form has the following call:

    _usageFunction exitCode message

e.g.

    _myFunction "$errorEnvironment" "Missing file $file"

The `exitCode` is required, and `0` is considered success.

- `usage` implementations SHOULD NEVER `exit`, instead it should return the passed in `exitCode`
- `message` - Is optional but highly recommended for all errors.

Typically it would be written as follows in your code:

    myFunction() {
        if ! curl -L "$bigFile" -o - > "$savedFile"; then
            _myFunction 1 "Unable to download $bigFile"
            return $?
        fi
        ..
    }
    _myFunction() {
       usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Extensions to the basic `usage` model typically prefix additional parameters before the `exitCode`.

## Usage components

Usage for a command typically consists of the following components:

- An example usage
- Arguments to the command and their meanings and descriptions
- Any further description

## Usage generation - two methods

The **first** version of usage generation uses `usageMain` which depends on functions defined locally so only works in isolated shell scripts.

The **most recent** version uses a file name and a function name and the document comments to generate the usage. Both work similarly.

### Usage using comments (Most recent)

The comment-method is more flexible as it allows for any name/value pair to be associated with the usage, but requires a `function`
and the current file to generate (as the code reads the script to extract the comment):

    #!/usr/bin/env bash

    set -eou pipefail

    cd "$(dirname "${BASH_SOURCE[0]}")/../.."

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

    # Process a cool file
    # Usage: myCoolScript
    # Argument: file - Required. File. The file to cool
    # Argument: directory - Required. Directory. The place to put the file
    # Argument: --help - Show this help and exit
    # Example:      myCoolScript my.cool ./coolOutput/
    myCoolScript() {
        file="${1-}"
        # ...
        if [ -z "$file" ]; then
            _myCoolScriptUsage 1 "Requires a file"
        fi
        if [ ! -f "$file" ]; then
            _myCoolScriptUsage 1 "$file is not a file"
        fi
    }
    _myCoolScriptUsage() {
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

As additional features are added (using different arguments), the comment method is likely the best bet long-term.

### English-based Argument Descriptions

- If a description contains the term `Required` which matches any case, then arguments are assumed to be required.

[⬅ Return to top](../index.md)
