# Hooks

Hooks are ways to change default behaviors in scripts, or just do something at a certain time.

All hooks should be in your project root located at `bin/hooks`. (This also can be overwritten or added to.)

If build has a default behavior for your hook, it's located at `bin/build/hooks`.

Most hooks are optional unless specified.

## [Version Hooks](../tools/version.md)

- `version-already` - Run code when `new-release.sh` is run but a new release already exists.
- `version-created` - This hook is run when `new-release.sh` creates a new release.
- `version-current` - Outputs a string which displays the current application version. Default hook uses the
  `docs/release` directory.
- `version-live` - The current published live version of the software. (Optional but **highly recommended.**)
- `version-notes` - When a new release notes file needs to be generated, this generates the new file if you want something custom.
- `version-notes-copyright` - And, if you want to have a custom copyright line, just add this hook.

## [Application Hooks](../tools/application.md)

- `application-environment` - Create the environment file. Default calls `environmentFileApplicationMake` with your
  desired environment. Currently used in `phpBuild`
- `application-tag` - The current tagged version of the software (e.g `v1.0.0rc71`)
- `application-id` - Returns a string checksum of the current application source code (unique checksum for code state)
- `maintenance` - Turn on or off maintenance
- `notify` - Notify administrator of somethiing important

## [Deployment Hooks](../tools/deploy.md)

- `deploy-start` - Run on deployed system. Begin deployment, after maintenance has been enabled (delete caches, etc.)
- `deploy-finish.sh` After new code is deployed (update local files or register server etc.)
- `deploy-confirm.sh` After new code is deployed make sure it is running correctly
- `deploy-activate` - Run on deployed system. During deployment install passed directory as new version of the app in
  current directory
- `deploy-finish` - Run on deployed system. Deployment is finished (before maintenance is turned off)
- `deploy-confirm` - Run on pipeline systems. Before finish, check that deployment succeeded remotely via an alternate
  mechanism (smoke tests)
- `deploy-cleanup` - Run on deployed system. After deployment, delete stray files or left overs from deployment if
  necessary.
- `deploy-revert` - Run on deployed system. After failed deployment, revert to previous version.

## Vendor Hooks

- `git-pre-commit` - A git pre-commit hook. Install it with `gitInstallHooks`.
- `github-release-before` - Run before [`github-release`](hooks/github-release.md) release the release to GitHub.
- `github-release-after` - Run after [`github-release`]( hooks/github-release.md) release the release to GitHub.

## [Testing Hooks](hooks/test.md)

- `test-setup` - Move or copy files prior to docker-compose build to build test container
- `test-runner` - Run unit and any other tests inside the container (Required for test scripts)
- `test-cleanup` - Reverse of `test-setup` hook actions

[⬅ Return to top](index.md)
