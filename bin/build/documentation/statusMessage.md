## `statusMessage`

> Output a status message and display correctly on consoles with animation and in log files

### Usage

    statusMessage [ --last ] [ --first ] [ --inline ] command

Output a status message
This is intended for messages on a line which are then overwritten using consoleLineFill
Clears the line and outputs a message using a command. Meant to show status but not use up an output line for it.
When $(consoleHasAnimation) is true:
$(--first) - clears the line and outputs the message starting at the left column, no newline
$(--last) - clears the line and outputs the message starting at the left column, with a newline
$(--inline) - Outputs the message at the cursor without a newline
When $(consoleHasAnimation) is false:
$(--first) - outputs the message starting at the cursor, no newline
$(--last) - outputs the message starting at the cursor, with a newline
$(--inline) - Outputs the message at the cursor with a newline

### Arguments

- `--last` - Flag. Optional. Last message to be output, so output a newline as well at the end.
- `--first` - Flag. Optional. First message to be output, only clears line if available.
- `--inline` - Flag. Optional. Inline message displays with newline when animation is NOT available.
- `command` - Required. Commands which output a message.

### Examples

    statusMessage decorate info "Loading ..."
    bin/load.sh >>"$loadLogFile"
    consoleLineFill

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- Intended to be run on an interactive console. Should support $(tput cols).

### Requires

throwArgument consoleHasAnimation catchEnvironment decorate validate consoleLineFill

