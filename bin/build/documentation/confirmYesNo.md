## `confirmYesNo`

> Read user input and return success on yes

### Usage

    confirmYesNo [ --default defaultValue ] [ --attempts attempts ] [ --timeout seconds ] [ --info ] [ --yes ] [ --no ] [ --help ] [ --handler handler ] [ message ... ]

Read user input and return 0 if the user says yes, or non-zero if they say no
Example: Will time out after 10 seconds, regardless (user must make valid input in that time):
Example:
Example:

### Arguments

- `--default defaultValue` - Boolean. Optional. Value to return if no value given by user
- `--attempts attempts` - PositiveInteger. Optional. User can give us a bad response this many times before we return the default.
- `--timeout seconds` - PositiveInteger. Optional. Wait this long before choosing the default. If no default, default is --no.
- `--info` - Flag. Optional. Add `Type Y or N` as instructions to the user.
- `--yes` - Flag. Optional. Short for `--default yes`
- `--no` - Flag. Optional. Short for `--default no`
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `message ...` - String. Any additional arguments are considered part of the message.

### Examples

    confirmYesNo --timeout 10 "Stop the timer!"

### Return codes

- `0` - Yes
- `1` - No

