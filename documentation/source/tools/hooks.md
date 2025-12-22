# Defined Hooks

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Top ](../index.md)
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

These hooks interact with `release-new.sh` and deployment tools but are intended to be used anywhere.

- `version-current` - Required. The current version. Defaults to the highest version in `docs/release`.
- `version-live` - Optional. Determine the live version.
- `version-created` - Optional. Run when a new version is created.
- `version-already` - Optional. Run when a new version is requested, but it already exists in the source code.

{__hookVersionAlready}

{__hookVersionCreated}

{__hookVersionCurrent}

{__hookVersionLive}

## Development Hooks

{__hookProjectActivate}

{__hookProjectActivate}

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

### Pre-commit 

{__hookGitPreCommit}

{__hookPreCommitShell}

{__hookPreCommitPHP}

### Post-commit

{__hookGitPostCommit}

## Test Hooks

{__hookTestSetup}

{__hookTestRunner}

{__hookTestCleanup}
