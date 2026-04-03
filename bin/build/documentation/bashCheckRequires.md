## `bashCheckRequires`

> Checks a bash script to ensure all requirements are met,

### Usage

    bashCheckRequires [ --help ] [ --ignore prefix. String. Optional. Ignore exact function names. ] [ --ignore-prefix prefix ] [ --report ] [ --require ] [ --unused ]

Checks a bash script to ensure all requirements are met, outputs a list of unmet requirements
Scans a bash script for lines which look like:
Each requirement token is:
- a bash function which MUST be defined
- a shell script (executable) which must be present
If all requirements are met, exit status of 0.
If any requirements are not met, exit status of 1 and a list of unmet requirements are listed

### Arguments

- `--help` - Flag. Optional. Display this help.
--ignore prefix. String. Optional. Ignore exact function names.
- `--ignore-prefix prefix` - String. Optional. Ignore function names which match the prefix and do not check them.
- `--report` - Flag. Optional. Output a report of various functions and handler after processing is complete.
- `--require` - Flag. Optional. Requires at least one or more requirements to be listed and met to pass
- `--unused` - Flag. Optional. Check for unused functions and report on them.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

token1 token2

