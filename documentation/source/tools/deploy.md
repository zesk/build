# Deploy Functions

Deployment is the upgrading of an application from one version to another. These functions handle this on a file-level
with various hooks and ways of backing out of a failed upgrade.

Versions of the application are kept in a local deployment repository which contains information about each deployment,
and switching between deployments is intended to be easy and straightforward to accomplish.

Applications are served via a link aliased to a directory which then changes based on the current deployment; this
minimizes moving parts to change deployment code bases.

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## Deploy Information

{deployApplicationVersion}
{deployPackageName}
{deployHasVersion}
{deployPreviousVersion}
{deployNextVersion}

## Deploy

{deployApplication}

## Utilities

{deployMove}
{deployMigrateDirectoryToLink}
{deployLink}
{deployRemoteFinish}

## Deployment Hooks

Deployment occurs as follows:

- `application-environment` - Optional. Run on deployment system. Create environment file for remote system.
- `deploy-start` - Optional. Run on each remote system.
- `deploy-activate` - Optional. Run on each remote system.
- `deploy-finish` - Optional. Run on each remote system.
- `deploy-confirm` - Optional. Run on deployment system.
- `deploy-revert` - Optional. Run on each remote system.

## Ordering of Hooks

Hooks are run, in this order:

### Deployment `deployApplication`

Most `deploy-foo` hooks should handle failure and return application state to a **stable** state.

1. `maintenance` `on` - On each deployed system
    - Fail: Nothing
2. `deploy-shutdown` - On each deployed system
    - Fail: `maintenance` `off`
3. `deploy-start` - On each deployed system
    - Fail: `maintenance` `off`
4. `deploy-activate` - On each deployed system
    - Fail: `maintenance` `off`
5. `deploy-finish` - On each deployed system
    - Fail: `maintenance` `off`
6. `maintenance` `off` - On each deployed system
    - Fail: Nothing

### Deployment `deployRemoteFinish`

Most `deploy-foo` hooks should handle failure and return application state to a **stable** state.

1. `deploy-cleanup` - On each deployed system
    - Fail: Nothing

## Hook documentation

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
