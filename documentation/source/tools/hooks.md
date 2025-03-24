# Defined Hooks

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## Context hook runners

These run within the current project regardless of where Zesk Build is loaded:

{hookVersionCurrent}
{hookVersionLive}

## Application hooks

{__hookNotify}
{__hookDocumentationComplete}
{__hookDocumentationError}

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
{__hookApplicationID}
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
