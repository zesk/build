# Test Hooks

[⬅ Return to hook index](index.md)


## `test-cleanup.sh` - Runs after tests have been run to clean up any

Runs after tests have been run to clean up any artifacts or other test files which
may have been generated.

## Exit codes

- `0` - Always succeeds

## `test-runner.sh` - Runs our tests; any non-zero exit code is considered a

Runs our tests; any non-zero exit code is considered a failure and will terminate
deployment steps.

The default hook for this fails with exit code 99 by default.

## Exit codes

- `0` - If the tests all pass
- `Non-Zero` - If any test fails for any reason

## `test-setup.sh` - Sets up our environment for our tests. May build a

Sets up our environment for our tests. May build a test image, set up a test database, start a test version of the
system, or deploy to a test environment for testing.

The default hook does nothing and exits successfully.

## Exit codes

- `0` - If the test setup was successful
- `Non-Zero` - Any error will terminate testing

[⬅ Return to hook index](index.md)
