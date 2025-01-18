# Environment variables which affect build scripts

[⬅ Return to top](index.md)

- `BUILD_CACHE` - Directory. Location for the build cache files. Defaults to `$HOME/.build`, then `$(buildHome)/.build`.
- `BUILD_VERSION_SUFFIX` - Default suffix used in `gitTagVersion`
- `BUILD_MAXIMUM_TAGS_PER_VERSION` - Integer. Default 1000. Affects `git-tag-version.sh`

- `BUILD_DEBUG` - Enable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.
- `BUILD_COLORS` - Force (`export BUILD_COLORS=true` or disable `export BUILD_COLORS=false` build and console colors). See `colors.sh`.
- `CI` - If this value is non-blank, then console `statusMessage`s are just output normally.

# Git

- `GIT_OPEN_LINKS` - Boolean. Set to `true` to have remote links opened upon display.

# Tool versioning

- `BUILD_COMPOSER_VERSION` - String. Default `latest`. Version of composer to use for building vendor directory. ({See:phpComposer})
- `BUILD_NPM_VERSION` - String. Default `latest`. Version of npm to install using native `npm` binary. (Affects [`npm.sh`](npm.md))
- `HOSTTYPE` - String. Affects which version of the AWS cli is installed (arm64 or amd64) (See `aws.sh`). OS-specific.

# GitHub Releases

- `GITHUB_ACCESS_TOKEN` - String. Used in `github-release.sh`. No default.
- `GITHUB_REPOSITORY_OWNER` - String. Used in `github-release.sh`. No default.
- `GITHUB_REPOSITORY_NAME` - String. Used in `github-release.sh`. No default.

# Build

- `BUILD_TARGET` - String. File to generate using `phpBuild`. Defaults to `app.tar.gz`.

# Deployment

- `APPLICATION_REMOTE_PATH` - Path on remote system. Used in `deployApplication`. No default.
- `DEPLOY_REMOTE_PATH` - Path on remote system. Used in `deployApplication`. No default.
- `DEPLOY_USER_HOSTS` - List of user@host strings. Used in `deployApplication`. No default.

# AWS related

Tools: `awsIPAccess`

- `AWS_REGION` - Default region for operations in AWS - required for `aws-ip-access.sh`
- `AWS_ACCESS_KEY_ID` - Credentials for `aws.sh` once installed
- `AWS_SECRET_ACCESS_KEY` - Credentials for `aws.sh` once installed

# Development

- `EDITOR` is used as a default value for `BUILD_VERSION_CREATED_EDITOR` (used to open files)

# Generated

- `APPLICATION_ID` - Code checksum representing the unique version of the application code (git commit SHA or equivalent)
- `APPLICATION_TAG` - Tag of deployed code (longer version, if not supplied same as `APPLICATION_ID`)
