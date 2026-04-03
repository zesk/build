## `testSuiteFunctionTested`

> When environment variable `TEST_TRACK_ASSERTIONS` is `true` – `testSuite` and assertion

### Usage

    testSuiteFunctionTested [ --help ] [ --help ] [ --verbose ] [ functionName ... ]

When environment variable `TEST_TRACK_ASSERTIONS` is `true` – `testSuite` and assertion functions track which functions take a function value (for example, `assertExitCode`) and track functions which are run, and stores them in the testing cache directory which accumulate after each test run unless the cache is cleared.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--help` - Flag. Optional. Display this help.
- `--verbose` - Flag. Optional. Show list of true results when all arguments pass.
- `functionName ...` - String. Function to look up to see if it has been tested. One or more.

### Return codes

- `0` - All functions were tested by the test suite at least once.
- `1` - At least one function was not tested by the test suite at least once.

### Environment

- {SEE:TEST_TRACK_ASSERTIONS.sh}

