# Hooks

[⬅ Return to documentation index](../index.md)

Hooks are scripts which are located in your project at:

    - `./bin/hooks/`

The hooks are executable scripts and have the name `hook-name.sh` where `hook-name` is how the hook is addressed and invoked.

Hooks are run via:

    runHook hook-name [ hookArguments ... ]
    runOptionalHook hook-name [ hookArguments ... ]

See [runHook](../tools/pipeline.md) and [runOptionalHook](../tools/pipeline.md) in the pipeline documentation.

And in some cases, a default hook is always available at `bin/build/hooks/`.

## Reference

- [Application Hooks](application.md)
- [Deployment Hooks](deployment.md)
- [Git Pre-Commit Hook](git-pre-commit.md)
- [GitHub Release Hooks](github-release.md)
- [Test Hooks](test.md)
- [Version Hooks](version.md)

## Quick Reference

# Hooks

- `deploy-start` - Run on deployed system. Begin deployment, after maintenance has been enabled
- `deploy-activate` - Run on deployed system. During deployment install passed directory as new version of the app in current directory
- `deploy-finish` - Run on deployed system. Deployment is finished (before maintenance is turned off)
- `deploy-confirm` - Run on pipeline systems. Before finish, check that deployment succeeded remotely via an alternate mechanism (smoke tests)
- `deploy-cleanup` - Run on deployed system. After deployment, delete stray files or left overs from deployment if necessary.
- `deploy-revert` - Run on deployed system. After failed deployment, revert to previous version.

- `maintenance.sh -` Turn on or off maintenance

- `github-release-before.sh` -
- `github-release-after.sh` -

- `make-env.sh` - Create the environment file (generally calls `bin/build/pipeline/make-env.sh` with your desired environment)

- `version-already.sh` - A new version was requested but it already exists
- `version-created.sh` - A new version was requested and created
- `version-current.sh` - The current version of the software in this codebase.
- `version-live.sh` - The current published live version of the software.

- `application-tag.sh` - The current tagged version of the software
- `application-id.sh` - Returns a string checksum of the current application source code (unique checksum for code state)

- `test-setup.sh` - Move or copy files prior to docker-compose build to build test container
- `test-runner.sh` - Run unit and any other tests inside the container
- `test-cleanup.sh` - Reverse of test-setup hook actions

[⬅ Return to top](index.md)

[⬅ Return to documentation index](../index.md)
