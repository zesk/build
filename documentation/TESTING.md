# Testing Zesk Build

Run `./bin/test.sh` with options as desired.

Tags:

- `slow` - Any test which is greater than 15 seconds (currently)
- `slow-non-critical` - Slow and does NOT need to be run for production.
- `deployment` - Deployment related?
- `docker` - Uses `docker`.
- `fast` - Fast tests.
- `package-install` - Installs a package in the operating system or does package manager manipulation
- `php-install` - Installs PHP as part of the test.
- `remote-dependency` - Has a dependency on a remote system (not us).
- `simple-php` - Uses the simple PHP application.
- `slow-30-seconds` - Slower than 30 seconds.
- `test-tags` -
- `testSuite` - Test suite tests. (Also `a` `b` `c` for ordering tests)
