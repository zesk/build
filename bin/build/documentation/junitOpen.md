## `junitOpen`

> Open tag for `testsuites`

### Usage

    junitOpen [ nameValue ... ] [ --help ]

Open tag for `testsuites`
Attributes:
- `name=Test run`
- `tests=8`
- `failures=1`
- `errors=1`
- `skipped=1`
- `assertions=20`
- `time=16.082687`
- `timestamp=2021-04-02T15:48:23`

### Arguments

- `nameValue ...` - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
- `--help` - Flag. Optional. Display this help.

### Examples

    <testsuites name="Test run" tests="8" failures="1" errors="1" skipped="1"
               assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23">

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

