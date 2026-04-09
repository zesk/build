## `junitTestCaseFailureOpen`

> Open tag for `failure` - test failed

### Usage

    junitTestCaseFailureOpen [ message ]

Open tag for `failure` - test failed
Argument ... - String. Optional. Name/value tag attributes
Attributes:
- `type=AssertionError`

### Arguments

- `message` - Optional. String. Why failure occurred.

### Examples

    <failure message="Expected value did not match." type="AssertionError">
        Failure description or stack trace
    </failure>

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

