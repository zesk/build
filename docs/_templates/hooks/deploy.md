# Deployment Hooks

[⬅ Return to hook index](index.md)

Deployment occurs as follows:

- `make-env` - Optional. Run on deployment system. Create environment file for remote system.
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

{hookMakeEnvironment}

{hookDeployStart} {hookDeployMove} {hookDeployConfirm} {hookDeployCleanup} {hookDeployFinish} {hookDeployRevert}

[⬅ Return to hook index](index.md)
