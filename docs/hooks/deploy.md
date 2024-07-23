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


### `runHook make-env` - Generate an environment file with environment variables (must be `export`ed)

Generate an environment file with environment variables (must be `export`ed)

If your project has specific environment variables, you can add them in your `make-env` hook.

#### Usage

    runHook make-env [ requiredEnvironment0 ... ] [ -- optionalEnvironment0 ... ]
    

#### Exit codes

- `0` - Always succeeds

#### See Also

- [function environmentFileApplicationMake
](./docs/tools/pipeline.md
) - [Create environment file `.env` for build.
](https://github.com/zesk/build/blob/main/bin/build/tools/pipeline.sh#L321
)


### `deploy-start.sh` - Deployment "start" script

Deployment "start" script

#### Examples

- Move directories to make deployment final

#### Exit codes

- `0` - This SHOULD exit successfully always 
#### Exit codes

- `0` - Always succeeds 
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
should do wahtever is required to ensure that.

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

[⬅ Return to hook index](index.md)
