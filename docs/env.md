# Environment variables which affect build scripts

[⬅ Return to top](index.md)

- `BUILD_VERSION_SUFFIX` - String. Default suffix used in `git-tag-version.sh`. Default is `rc` if not specified.
- `BUILD_MAXIMUM_TAGS_PER_VERSION` - Integer. Default 1000. Affects `git-tag-version.sh`

- `BUILD_DEBUG` - Enable debugging globally in the build scripts. Lots of output and tracing so beware. Affects `deploy-to.sh`, `php-build.sh`, `remote-deploy-finish.sh`, and `aws-ip-access.sh`.
- `BUILD_COLORS` - Force (`export BUILD_COLORS=1` or disable `export BUILD_COLORS=0` build and console colors). See `colors.sh`.
- `CI` - If this value is non-blank, then console `statusMessage`s are just output normally.

# Tool versioning

- `BUILD_COMPOSER_VERSION` - String. Default `latest`. Version of composer to use for building vendor directory. (See [`composer.sh`](composer.md))
- `BUILD_NPM_VERSION` - String. Default `latest`. Version of npm to install using native `npm` binary. (Affects [`npm.sh`](npm.md))
- `HOSTTYPE` - String. Affects which version of the AWS cli is installed (arm64 or amd64) (See `aws-cli.sh`). OS-specific.

# GitHub Releases

- `GITHUB_ACCESS_TOKEN` - String. Used in `github-release.sh`. No default.
- `GITHUB_REPOSITORY_OWNER` - String. Used in `github-release.sh`. No default.
- `GITHUB_REPOSITORY_NAME` - String. Used in `github-release.sh`. No default.
# Build

- `BUILD_TARGET` -String. File to generate using `php-build.sh`. Defaults to `app.tar.gz`.

# Deployment

- `APPLICATION_REMOTE_PATH` - Path on remote system. Used in `php-deploy.sh`. No default.
- `DEPLOY_REMOTE_PATH` - Path on remote system. Used in `php-deploy.sh`. No default.
- `DEPLOY_USER_HOSTS` - List of user@host strings. Used in `php-deploy.sh`. No default.

# AWS related

Tools: `aws-ip-access.sh`

- `AWS_REGION` - Default region for operations in AWS - required for `aws-ip-access.sh`
- `AWS_ACCESS_KEY_ID` - Credentials for `aws-cli.sh` once installed
- `AWS_SECRET_ACCESS_KEY` - Credentials for `aws-cli.sh` once installed

# Development

- `BUILD_VERSION_CREATED_EDITOR` is used in `bin/hooks/version-created.sh` to open the new file automatically
- `EDITOR` is used as a default value for `BUILD_VERSION_CREATED_EDITOR` (used to open files)

# Generated

- `APPLICATION_CHECKSUM` - Code checksum representing the unique version of the application code (git commit SHA or equivalent)
- `APPLICATION_TAG` - Tag of deployed code (may differ from version)
