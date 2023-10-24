# Zesk Build tools

Pipeline and build-related tools which are useful across a variety of projects.

This toolkit makes the following assumptions:

- You are using this with another project to help with your pipeline and build steps.
- Binaries from this project installed at `./bin/build/`
- Your project: Release notes located at `./docs/release` which are named `v1.0.0.md` where prefix matches tag names (`v1.0.0`)
- A hook exists in your project `./bin/hooks/version-current.sh`
- Optionally a binary exists in your project `./bin/hooks/version-live.sh` (for `bin/build/new-release.sh` - will create a new version each time without it)
- For certain functions, your shell script should define a function `usage` for argument errors and short documentation.
- Most build operations occur at the project root directory but most can be run anywhere by supplying a parameter if needed (`composer.sh` specifically)
- A `.build` directory will be created at your project root which contains marker files as well as log files for the build. It can be deleted safely at any time, but may contain evidence of failures.

To use in your pipeline:

- copy `bin/build/build-setup.sh` into your project (changing `relTop` if needed) manually
- run it before you need your `bin/build` directory

## Project structure

- `bin/build/*.sh` - Build scripts and tools
- `bin/build/tools/*.sh` - Tool functions
- `bin/build/pipeline/*.sh` - Tools or steps for deployment
- `bin/build/install/*.sh` - Install dependencies in the pipeline

## Documentation

- [Bash Functions Reference](./tools/index.md)
- [Environment variables which affect build](env.md)

### Generic tools

- [`envmap.sh`](envmap.sh.md) - Map environment values into files
- [`chmod-sh.sh`](chmod-sh.sh.md) - Make `.sh` files executable
- [`cannon.sh`](cannon.sh.md) - Map strings in files to make global changes. Dangerous.
- [`new-release.sh`](new-release.sh.md) - Create a new release for the current project.
- [`version-last.sh`](version-last.sh.md) - The last version in the list of tags for this project
- [`version-list.sh`](new-release.sh.md) - The list of versions for this project, in order by semantic versioning
- [`tools.sh`](./tools/index.md) - Build shell tools and all related functions. Include this via `. ./bin/build/tools.sh`
- [`release-notes.sh`](./release-notes.md) - Return path to current release notes file (`./docs/release/`)

### Install tools in the pipeline

- [`apt.sh`](apt.sh.md) - Ensure apt-get is up to date.
- [`aws-cli.sh`](aws-cli.sh.md) - Install the Amazon Web Services command line for usage in the pipeline.
- [`docker-compose.sh`](docker-compose.sh.md) - Ensure `docker-compose` is available in the pipeline.
- [`git.sh`](git.sh.md) - Ensure `git` is available in the pipeline.
- [`mariadb-client.sh`](mariadb-client.sh.md) - Ensure `mariadb` (and `mysql`) is available in the pipeline.
- [`npm.sh`](npm.sh.md) - Install `npm` for use in the pipeline.
- [`php-cli.sh`](php-cli.sh.md) - Install the `php` command line in the pipeline image.
- [`prettier.sh`](prettier.sh.md) - Ensure `prettier` is available in the pipeline.
- [`python.sh`](python.sh.md) - Ensure `python` (Version 3) is available in the pipeline.

### Use tools in the pipeline

- [`aws-ip-access.sh`](aws-ip-access.sh.md) - Grant access to the current IP to AWS security groups
- [`composer.sh`](composer.sh.md) - Run a version of composer on my codebase
- [`deploy-to.sh`](deploy-to.sh.md) - Deploy an application to a remote host
- [`deploy.sh`](deploy.sh.md) - Deploy an application to one or more hosts
- [`git-tag-version.sh`](git-tag-version.sh.md) - Tag a development or release version in git
- [`github-release.sh`](github-release.sh.md) - Generate a GitHub release
- [`github-version-live.sh`](github-version-live.sh.md) - Tool to find the current release version for any GitHub hosted repository
- [`make-env.sh`](make-env.sh.md) - Generate an `.env` file with a list of required environment values
- [`php-build.sh`](php-build.sh.md) - Build a PHP application using `composer`
- [`php-test.sh`](php-test.sh.md) - Test a PHP application using `docker-compose` and `composer`
- [`remote-deploy-finish.sh`](remote-deploy-finish.sh.md) - Run on the remote system after a deployment is deployed but before it is finished to do any work on the remote system.
- [`undeploy.sh`](undeploy.sh.md) - Reverse of `deploy.sh` - will revert an application on a host

### Operations Tools

- [`crontab-application-sync.sh`](crontab-application-sync.sh.md) - Keep a crontab up to date with multiple applications


