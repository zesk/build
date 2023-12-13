# Deployment Hooks

[⬅ Return to hook index](index.md)

Deployment occurs as follows:

- `make-env` - Optional. Run on deployment system. Create environment file for remote system.
- `deploy-start` - Optional. Run on each remote system.
- `deploy-move` - Optional. Run on each remote system.
- `deploy-finish` - Optional. Run on each remote system.
- `deploy-confirm` - Optional. Run on deployment system.
- `deploy-undo` - Optional. Run on each remote system.

{hookMakeEnvironment}

{hookDeployStart}
{hookDeployMove}
{hookDeployConfirm}
{hookDeployCleanup}
{hookDeployFinish}
{hookDeployUndo}

[⬅ Return to hook index](index.md)
