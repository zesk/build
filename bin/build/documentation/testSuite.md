#### Tag filters
Prefix a tag with `+` for `--tag` or `--skip-tag` queries to add the meaning "previous *AND*".
- `--tag foo --tag bar` means tests must have `foo` tag OR must have `bar` tag
- `--tag foo --tag +bar` means tests must have `foo` tag AND must have `bar` tag (must have both)
- `--skip-tag foo --skip-tag bar` means skip any test with `foo` tag OR with any test with `bar` tag (either)
- `--skip-tag foo --skip-tag +bar` means skip any test with `foo` tag AND with the `bar` tag (must have both)
- `--tag a --tag +b --tag c --tag +d --tag +e` is `(a and b) or (c and d and e)`
Your test functions can contain tags as follows:
    # Tag: tagA tagB
    # Tag: tagC
    # Test-Platform: !alpine alpine !linux linux !darwin darwin
    # Test-Skip: true
    # Test-Housekeeper: false
    # Test-Plumber: true
    # Test-TAP-Directive: Something
    # Test-After: testWhichShouldGoBefore
    # Test-Before: testWhichShouldGoAfter
    # Test-Fail: true
    testThingy() {
       ...
    }
Environment variables:
- `BUILD_TEST_FLAGS` - SemicolonDelimitedList. Add flags like 'Plumber:false' to disable settings across tests.
- `BUILD_DEBUG` - Many settings to debug different systems, comma-delimited.
Filters (`--tag` and `--skip-tag`) are applied in order after the function pattern or suite filter.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--clean` - Flag. Optional. Delete test artifact files and exit. (No tests run)
-l |- ` --list` - Flag. Optional. List all test names (which match if applicable).
- `--env-file environmentFile` - EnvironmentFile. Optional. Load one ore more environment files prior to running tests
- `--index-file indexFile` - RealDirectoryFile. Optional. If supplied and exists, uses the index file for tests.
- `--cache-path cachePath` - Directory. Optional.
- `--make-index` - Flag. Optional. Generate the index file if supplied and quit.
- `--continue` - Flag. Optional. Continue from last successful test.
- `-c` - Flag. Optional. Continue from last successful test.
- `--delete directoryOrFile` - FileDirectory. Optional. A file or directory to delete when the test suite terminates.
- `--delete-common` - Flag. Delete `./vendor` and `./node_modules` (and other temporary build directories) by default.
- `--debug` - Flag. Optional. Enable debugging for `--junit` (saves caches).
- `--verbose` - Flag. Optional. Be verbose.
- `--stop` - Flag. Optional. Stop after a failure instead of attempting to continue.
- `--coverage - Flag. Optional. Feature in progress` - generate a coverage file for tests.
- `--no-stats` - Flag. Optional. Do not generate a test.stats file showing test timings when completed.
- `--messy` - Flag. Optional. Do not delete test artifact files afterwards.
- `--fail executor` - Callable. Optional. One or more programs to run on the failed test files. Takes arguments: testName testFile testLine
- `--cd-away` - Flag. Optional. Change directories to a temporary directory before each test.
- `--tap tapFile` - FileDirectory. Optional. Output test results in TAP format to `tapFile`.
- `--junit junitFile` - FileDirectory. Optional. Output test results in junit format to `junitFile`. If a directory is specified the output is to `junit.xml`.
--show |- ` --suites` - Flag. Optional. List all test suites.
-1 | --suite |- ` --one testSuite` - String. Optional. Add one test suite to run.
- `--tag tagName` - String. Optional. Include tests (only) tagged with this name.
--list-tags | --tags |- ` --show-tags` - Flag. Optional. Of the matched tests, display the tags that they have, if any. Unique list.
- `--skip-tag tagName` - String. Optional. Skip tests tagged with this name.
- `testFunctionPattern ...` - String. Optional. Test function (or substring of function name) to run.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `test-dump-environment` - When set tests will dump the environment at the end.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TEST_FLAGS.sh} {SEE:BUILD_DEBUG.sh}

