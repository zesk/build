# Deployment Hooks

[⬅ Return to hook index](index.md)


Deployment occurs as follows:

- `make-env` - Optional. Run on deployment system. Create environment file for remote system.
- `deploy-start` - Optional. Run on each remote system.
- `deploy-move` - Optional. Run on each remote system.
- `deploy-finish` - Optional. Run on each remote system.
- `deploy-confirm` - Optional. Run on deployment system.
- `deploy-undo` - Optional. Run on each remote system.


## `hookMakeEnvironment` - Default hook runs `bin/build/pipeline/make-env.sh` directly. To customize this

Default hook runs `bin/build/pipeline/make-env.sh` directly. To customize this
override this hook in your project.

## Exit codes

- `0` - Always succeeds


## `deploy-start.sh` - Deployment "start" script

$Deployment "start" script

## Examples

    - Move directories to make deployment final

## Exit codes

- `0` - This SHOULD exit successfully always

## Exit codes

- `0` - Always succeeds

## `deploy-confirm.sh` - Deployment confirmation script

should do wahtever is required to ensure that.

## Examples

    - Enable a health endpoint which returns version number and ensure all servers return the same version number (which was just updated)
    - Check the home page for a version number
    - Check for a known artifact (build sha) in the server somehow
    - etc.

## Exit codes

- `0` - Continue with deployment
- `Non-zero` - Any non-zero exit code will run `deploy-undo` hook on all systems and cancel deployment

## Errors

Unable to find "hookDeployMove" (from "./docs/templates/hooks/deploy.md") in "./bin/"

## `deploy-cleanup.sh` - Run after a successful deployment

Run on remote systems after deployment has succeeded on all systems.

This step must always succeed on the remote system; the deployment step prior to this
should do wahtever is required to ensure that.

## Exit codes

- `0` - Always succeeds

## Errors

Unable to find "hookDeployMove" (from "./docs/templates/hooks/deploy.md") in "./bin/"

## `deploy-finish.sh` - Deployment "finish" script

$Deployment "finish" script

## Examples

    - Move directories to make deployment final

## Exit codes

- `0` - This SHOULD exit successfully always

## Errors

Unable to find "hookDeployMove" (from "./docs/templates/hooks/deploy.md") in "./bin/"

## `deploy-undo.sh` - Deployment "undo" script

After a deployment was successful on a host, this undos that deployment and goes back to the previous version.

## Exit codes

- `0` - This SHOULD exit successfully always

[⬅ Return to hook index](index.md)
