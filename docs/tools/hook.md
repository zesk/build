# Hooks

Hooks are called to enable custom actions at specific times which can be overwritten or intercepted by the application.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

# Version hooks

These hooks interact with `new-release.sh` and deployment tools but are intended to be used anywhere.

- `version-current` - Required. The current version. Defaults to the highest version in `docs/release`.
- `version-live` - Optional. Determine the live version.
- `version-created` - Optional. Run when a new version is created.
- `version-already` - Optional. Run when a new version is requested, but it already exists in the source code.


### `version-already.sh` - Run whenever `new-version.sh` is run and a version already exists

Run whenever `new-version.sh` is run and a version already exists

Opens the release notes in the current editor.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook

### `version-created.sh` - Run whenever `new-version.sh` is run and a version was just

Run whenever `new-version.sh` is run and a version was just created.

Opens the release notes in the current editor.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook

### `version-current.sh` - Hook to return the current version

Hook to return the current version

Defaults to the last version numerically found in `docs/release` directory.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_CREATED_EDITOR - Define editor to use to edit release notes
EDITOR - Default if `BUILD_VERSION_CREATED_EDITOR` is not defined

### `__hookVersionLive` - Fetch the current live version of the software

Fetch the current live version of the software

#### Usage

    __hookVersionLive
    

#### Exit codes

- `0` - Always succeeds

## Deployment Hooks


### `__hookApplicationEnvironment` - Hook is run to generate the application environment file

Hook is run to generate the application environment file
Outputs environment settings, one per line to be put into an environment file
See `environmentFileApplicationMake` for usage and arguments.

#### Usage

    __hookApplicationEnvironment
    

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function {fn}]({documentationPath}) - [{summary}]({sourceLink})

### `application-id.sh` - Generate a unique ID for the state of the application

Generate a unique ID for the state of the application files

The default hook uses the short git sha:

    git rev-parse --short HEAD

#### Examples

    885acc3

#### Exit codes

- `0` - Always succeeds

### `application-tag.sh` - Get the "tag" (or current display version) for an application

Get the "tag" (or current display version) for an application

The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.

#### Exit codes

- `0` - Always succeeds

### `maintenance.sh` - Toggle maintenance on or off. The default version of this

Toggle maintenance on or off. The default version of this modifies
the environment files for the application by modifying the `.env.local` file
and dynamically adding or removing any line which matches the MAINTENANCE variable.

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_MAINTENANCE_VARIABLE - If you want to use a different environment variable than `MAINTENANCE`, set this environment variable to the variable you want to use.


### `deploy-start.sh` - Deployment "start" script

Deployment "start" script

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always

### `deploy-move.sh` - Deployment move script

This is called where the current working directory at the time of
running is the **new** application and the `applicationPath` which is
passed as an argument is the place where the **new** application should be moved to
in order to activate it.

#### Usage

    runHook deploy-activate applicationPath
    

#### Arguments



#### Exit codes

- `0` - This is called to replace the running application in-place

### `deploy-confirm.sh` - Deployment confirmation script

should do wahtever is required to ensure that.

#### Examples

- Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
- Check the home page for a version number
- Check for a known artifact (build sha) in the server somehow
- etc.

#### Exit codes

- `0` - Continue with deployment
- `Non-zero` - Any non-zero exit code will run `deploy-revert` hook on all systems and cancel deployment

### `deploy-cleanup.sh` - Run after a successful deployment

Run on remote systems after deployment has succeeded on all systems.

This step must always succeed on the remote system; the deployment step prior to this
should do whatever is required to ensure that.

#### Exit codes

- `0` - Always succeeds

### `deploy-finish.sh` - Deployment "finish" script

$\Deployment "finish" script

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always

### `deploy-revert.sh` - Deployment "undo" script

After a deployment was successful on a host, this undos that deployment and goes back to the previous version.

#### Exit codes

- `0` - This SHOULD exit successfully always

## Git hooks


### `git-pre-commit.sh` - The `git-pre-commit` hook self-installs as a `git` pre-commit hook in

The `git-pre-commit` hook self-installs as a `git` pre-commit hook in your project and will
overwrite any existing `pre-commit` hook.`

It will:
1. Updates the help file templates
2. Checks all shell files for errors

#### Exit codes

- `0` - Always succeeds

### `git-post-commit.sh` - The `git-post-commit` hook will be installed as a `git` post-commit

The `git-post-commit` hook will be installed as a `git` post-commit hook in your project and will
overwrite any existing `post-commit` hook.

Merges `main` and `staging` and pushes to `origin`

#### Exit codes

- `0` - Always succeeds

## Test Hooks


### `test-setup.sh` - Sets up our environment for our tests. May build a

Sets up our environment for our tests. May build a test image, set up a test database, start a test version of the
system, or deploy to a test environment for testing.

The default hook does nothing and exits successfully.

#### Exit codes

- `0` - If the test setup was successful
- `Non-Zero` - Any error will terminate testing

### `test-runner.sh` - Runs our tests; any non-zero exit code is considered a

Runs our tests; any non-zero exit code is considered a failure and will terminate
deployment steps.

The default hook for this fails with exit code 99 by default.

#### Exit codes

- `0` - If the tests all pass
- `Non-Zero` - If any test fails for any reason

### `test-cleanup.sh` - Runs after tests have been run to clean up any

Runs after tests have been run to clean up any artifacts or other test files which
may have been generated.

#### Exit codes

- `0` - Always succeeds