## `junitTestCaseOpen`

> Open tag for `testcase` - Test case

### Usage

    junitTestCaseOpen [ nameValue ... ] [ --help ]

Open tag for `testcase` - Test case
- `name=testCase1`
- `classname=Tests.Registration`
- `assertions=2`
- `time=2.436`
- `file=tests/registration.code`
- `line=24`

### Arguments

- `nameValue ...` - Optional. String. A list of name value pairs (unquoted) to output as XML `property` tags.
- `--help` - Flag. Optional. Display this help.

### Examples

    <testcase name="testCase1" classname="Tests.Registration" assertions="2"
        time="2.436" file="tests/registration.code" line="24"/>

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

