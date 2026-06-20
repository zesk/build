##### Tag filters

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

> Location: `bin/build/tools/test.sh`

#### Arguments

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

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `test-dump-environment` - When set tests will dump the environment at the end.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_TEST_FLAGS` Test Flags]({rel}env/#testing) – **String**. Test flags affect controls and how tests are run. [`BUILD_DEBUG` Debugging Flag]({rel}env/#build_configuration) – **CommaDelimitedList**. Constant for turning debugging on during build to find errors

#### Requires

- [decorate]({rel}tools/decorate.md#decorate) - decorate text using colors and styles ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L144))
- [cpuLoadAverage]({rel}tools/cpu.md#cpuloadaverage) - Get the load average using uptime ([source](https://github.com/zesk/build/blob/main/bin/build/tools/platform.sh#L390))
- [consoleConfigureColorMode]({rel}tools/console.md#consoleconfigurecolormode) - Print the suggested color mode for the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/console.sh#L110))
- [buildEnvironmentLoad]({rel}tools/build.md#buildenvironmentload) - Load one or more environment settings from the environment file ([source](https://github.com/zesk/build/blob/main/bin/build/tools/build.sh#L412))
- [catchEnvironment]({rel}tools/sugar-core.md#catchenvironment) - Run \`command\`, upon failure run \`handler\` with an environment error ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L247))
- [bashCoverage]({rel}tools/coverage.md#bashcoverage) - Collect code coverage statistics for a code sample ([source](https://github.com/zesk/build/blob/main/bin/build/tools/coverage.sh#L15))

