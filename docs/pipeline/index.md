### Use tools in the pipeline

- [`composer.sh`](./pipeline/composer.sh.md) - Run a version of composer on my codebase
- [`deploy-to.sh`](./pipeline/deploy-to.sh.md) - Deploy an application to a remote host
- [`deploy.sh`](./pipeline/deploy.sh.md) - Deploy an application to one or more hosts
- [`git-tag-version.sh`](./pipeline/git-tag-version.sh.md) - Tag a development or release version in git
- [`aws-ip-access.sh`](./pipeline/aws-ip-access.sh.md) - Grant access to the current IP to AWS security groups
- [`github-release.sh`](./pipeline/github-release.sh.md) - Generate a GitHub release
- [`github-version-live.sh`](./pipeline/github-version-live.sh.md) - Tool to find the current release version for any GitHub hosted repository
- [`make-env.sh`](./pipeline/make-env.sh.md) - Generate an `.env` file with a list of required environment values
- [`php-build.sh`](./pipeline/php-build.sh.md) - Build a PHP application using `composer`
- [`php-test.sh`](./pipeline/php-test.sh.md) - Test a PHP application using `docker-compose` and `composer`
- [`remote-deploy-finish.sh`](./pipeline/remote-deploy-finish.sh.md) - Run on the remote system after a deployment is deployed but before it is finished to do any work on the remote system.
- [`undeploy.sh`](./pipeline/undeploy.sh.md) - Reverse of `deploy.sh` - will revert an application on a host

### Operations Tools

- [`crontab-application-sync.sh`](crontab-application-sync.sh.md) - Keep a crontab up to date with multiple applications
