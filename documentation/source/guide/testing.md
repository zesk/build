# Testing

Zesk Build has a complete testing and assertion platform which allows you to write tests for your Bash scripts with a
lot of extra functionality which makes it easy to use.

## Basic setup

In the default setup, create bash files for testing:

- `./test/support/` - Functions you use for your own testing only (optional)
- `./test/tests/*-tests.sh` - Test functions. Each file represents a suite of tests. Any function which begins with the
  word `test` is considered a test when defined in these files.

You can copy `bin/build/test.sample.sh` to `bin/test.sh`

You are ready to test!

## Writing a test

Tests are run and given a private temporary directory to track file leaks, as well as checking for environment variable
leaks.

Your tests should call an [assertion](../tools/assert.md) function but can do anything and should return 0 upon success.

Your test should NOT output anything to `stderr` - doing this is considered a test failure. If necessary, redirect to
`stdout` or avoid using `stderr`.

A simple test:

    testPlural() {
        assertEquals "dogs" "$(plural 2 dog)" || return $?
    }

## Testing assistants

The `plumber` monitors your function and ensures you do not declare a variable which is then leaked to the outside. This
occurs when you forget to declare local variables as `local`:

    testHasLeaks() {
        local handler="returnMessage"
        dogma=$(fileTemporaryName "$handler") || return $?
    }

The above function leaks variables (`dogma`) and leaks a temporary file around `$dogma` which is not deleted. Both are
an error.

If you find you need to turn this functionality off, add the tags to disable the functionality to your test function:

    # Test-Housekeeper: false
    # Test-Plumber: false
    testHasLeaks() {
        local handler="returnMessage"
        dogma=$(fileTemporaryName "$handler") || return $?
    }

## Assertion cheat sheet

### Text

- `assertEquals "$expected" "$actual"`
- `assertNotEquals "$expected" "$actual"`
- `assertStringEmpty "$text" [ "$message" ... ]`
- `assertStringNotEmpty "$text" [ "$message" ... ]`
- `assertContains "$needle" "$haystack" [ ... ]`
- `assertNotContains "$needle" "$haystack" [ ... ]`

### Execution

- `assertNotExitCode "$returnCode" "$command" ...`
- `assertExitCode "$returnCode" "$command" ...`
- `assertOutputDoesNotContain "$expectedString" "$command" ...`
- `assertOutpuContains "$expectedString" "$command" ...`
- `assertOutputEquals "$expectedString" "$command" ...`

### Files and Directories

- `assertFileExists "$file" [ "$message" ... ]`
- `assertFileContains "$file" "$matchString0" "$matchString1" ...`
- `assertFileDoesNotContain "$file" "$matchString0" "$matchString1" ...`
- `assertFileSize "$expectedSize" "$fileName"`
- `assertNotFileSize "$expectedSize" "$fileName"`
- `assertZeroFileSize "$fileName"`
- `assertDirectoryNotEmpty "$directory" [ "$message" ... ] `
- `assertDirectoryEmpty "$directory" [ "$message" ... ] `

### Numbers

- `assertGreaterThan "$leftValue" "$rightValue"` -> `leftValue > rightValue`
- `assertGreaterThanOrEqual "$leftValue" "$rightValue"` -> `leftValue >= rightValue`
- `assertLessThan "$leftValue" "$rightValue"` -> `leftValue < rightValue`
- `assertLessThanOrEqual "$leftValue" "$rightValue"` -> `leftValue <= rightValue`

## Tagging tests

You can tag tests using the standard Zesk Build documentation. The following flags are honored:

- `Tag` - Tag your tests with any string keyword separated by spaces. These can be used in `testSuite` calls with
  `--tag` or `--skip-tag` (and shown via `--list-tags`)
- `Test-Housekeeper` - Set to `true` or `false` to enable or disable the `housekeeper` for your test
- `Test-Plumber` - Set to `true` or `false` to enable or disable the `plumber` for your test
- `Test-Build-Home` - Set to `true` if you need your test to run when the current directory is also `BUILD_HOME`
  otherwise you are put inside a temporary sandbox directory.
- `Test-Platform` - Set to one or more space-delimited strings:
    - `alpine`, `!alpine` - Alpine Linux (or NOT)
    - `darwin`, `!darwin` - Mac OS X (or NOT)
    - `linux`, `!linux` - Neither Alpine/Mac OS X - Generic Linux (or NOT)
- `Test-Housekeeper-Overhead` - Set to `true` to display `housekeeper` overhead (this tends to be SLOW)
- `Test-Fail` - Set to `true` if you want the semantics of failure to be reversed.

Globals flags can be set using `BUILD_TEST_FLAGS` and are inherited to the test level:

- `Assert-Plumber:true` - Set this globally to have each assertion also do plumber tests (finer grained capture with
  slower testing cost)

Global flags are separated by a semicolon: `;`

Examples:

    BUILD_TEST_FLAGS='Plumber:true;Assert-Plumber:true;Housekeeper:false' bin/test.sh 

