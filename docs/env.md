# Environment variables which affect build scripts

- `BUILD_VERSION_SUFFIX` - String. Default suffix used in `git-tag-version.sh`. Default is `rc` if not specified.
- `BUILD_MAXIMUM_TAGS_PER_VERSION` - Integer. Default 1000. Affects `git-tag-version.sh`

# Tool versioning

- `BUILD_COMPOSER_VERSION` - String. Default `latest`. Version of composer to use for building vendor directory. (See [`composer.sh`](composer.sh.md))
- `BUILD_NPM_VERSION` - String. Default `latest`. Version of npm to install using native `npm` binary. (Affects [`npm.sh`](npm.sh.md))
- `HOSTTYPE` - Affects which version of the AWS cli is installed (arm64 or amd64) (See `aws-cli.sh`)

# GitHub Releases

- `GITHUB_ACCESS_TOKEN` - Used in `github-release.sh`
- `GITHUB_REPOSITORY_OWNER` - Used in `github-release.sh`
- `GITHUB_REPOSITORY_NAME` - Used in `github-release.sh`
# Build

- `BUILD_TARGET` - File to generate using `php-build.sh`

# Deployment

- `APPLICATION_REMOTE_PATH` - Used in `php-deploy.sh`
- `DEPLOY_REMOTE_PATH` - Used in `php-deploy.sh`
- `DEPLOY_USER_HOSTS` - Used in `php-deploy.sh`

# AWS related

Tools: `aws-ip-access.sh`

- `AWS_REGION` - Default region for operations in AWS - required for `aws-ip-access.sh`
- `AWS_ACCESS_KEY_ID` - Credentials for `aws-cli.sh` once installed
- `AWS_SECRET_ACCESS_KEY` - Credentials for `aws-cli.sh` once installed