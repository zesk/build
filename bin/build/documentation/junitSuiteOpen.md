## `junitSuiteOpen`

> Open tag for `testsuite`

### Usage

    junitSuiteOpen [ nameValue ... ] [ --help ]

Open tag for `testsuite`
Attributes:
- `name=Tests.Registration`
- `tests=8`
- `failures=1`
- `errors=1`
- `skipped=1`
- `assertions=20`
- `time=16.082687`
- `timestamp=2021-04-02T15:48:23`
- `file=tests/registration.code`

### Arguments

- `nameValue ...` - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
- `--help` - Flag. Optional. Display this help.

### Examples

    <testsuite name="Tests.Registration" tests="8" failures="1" errors="1" skipped="1"
         assertions="20" time="16.082687" timestamp="2021-04-02T15:48:23"
         file="tests/registration.code">

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

