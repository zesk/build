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

{__hookVersionAlready}
{__hookVersionCreated}
{__hookVersionCurrent}
{__hookVersionLive}

## Deployment Hooks

{__hookApplicationEnvironment}
{__hookApplicationChecksum}
{__hookApplicationTag}
{__hookMaintenance}

{__hookDeployStart}
{__hookDeployMove}
{__hookDeployConfirm}
{__hookDeployCleanup}
{__hookDeployFinish}
{__hookDeployRevert}

## Git hooks

{__hookGitPreCommit}
{__hookGitPostCommit}

## Test Hooks

{__hookTestSetup}
{__hookTestRunner}
{__hookTestCleanup}
