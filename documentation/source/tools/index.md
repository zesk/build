# Tools

- [Assertion](./assert.md)
- [Application](./application.md)
- [Binaries (direct)](./bin.md)
- [Color](./colors.md)
- [Console](./console.md)
- [Date](./date.md)
- [Debug](./debug.md)
- [Decoration](./decoration.md)
- [Deploy](./deploy.md)
- [Deployment](./deployment.md)
- [Directory](./directory.md)
- [Documentation](./documentation.md)
- [Environment](./environment.md)
- [File](./file.md)
- [Function interfaces](./interface.md)
- [Floating Point](./float.md)
- [Hook API](./hook.md)
- [Hooks](./hooks.md)
- [Identical](./identical.md)
- [Installation](./install.md)
- [Interactive](./interactive.md)
- [Log](./log.md)
- [Operating System](./os.md)
- [Pipeline](./pipeline.md)
- [Process](./process.md)
- [Self](./build.md)
- [Sugar](./sugar.md)
- [Testing](./test.md)
- [Text](./text.md)
- [Type](./type.md)
- [URL](./url.md)
- [Usage](./usage.md)
- [Utilities](./utilities.md)
- [Version](./version.md)
- [Web](./web.md)

# Software Integration

- [Amazon Web Services](./aws.md)
- [BitBucket](./bitbucket.md)
- [Crontab](./crontab.md)
- [daemontools](./daemontools.md)
- [Darwin](./darwin.md)
- [Docker](./docker.md)
- [Git](./git.md)
- [GitHub](./github.md)
- [MariaDB](./mariadb.md)
- [Markdown](./markdown.md)
- [npm](./npm.md)
- [PHP](./php.md)
- [SSH](./ssh.md)
- [System V Init](./sysvinit.md)
- [Terraform](./terraform.md)
- [OpenTofu](./opentofu.md)
- [Vendor](./vendor.md)

# Package Managers

Wrappers for these are in [package tools](./package.md).

- [Alpine Package Manager](./apk.md)
- [Apt Package Manager](./apt.md)
- [Homebrew](./brew.md)

If needed (and not massively complex) &mdash; will add platform-generic installation names in the future. Currently assumes packages are named identically between platforms.

# How to include in your scripts

The `tools.sh` shell is the only include you need in your scripts:

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

(see `bin/build/identical/__tools.sh` for an error-reporting loader)

Once included, all functions here are available for use:
