# Tools

## Shell Tools

- [Bash](./bash.md)
- [Binaries (direct)](./bin.md)
- [Color](./colors.md)
- [Completion](./completion.md)
- [Console](./console.md)
- [Cursor](./cursor.md)
- [Decoration](./decoration.md)
- [Developer](./developer.md)
- [Interactive](./interactive.md)
- [Prompt](./prompt.md)
- [Readline](./readline.md)

- [Self](./build.md)

## Testing

- [Assertion](./assert.md)
- [Coverage](./coverage.md)
- [Debug](./debug.md)
- [Testing](./test.md)

## Language Tools

- [Argument](./argument.md)
- [Deprecated](./deprecated.md)
- [Usage](./usage.md)
- [Validate](./validate.md)
- [Sugar](./sugar.md)

## System Tools

- [Directory](./directory.md)
- [Date](./date.md)
- [Dump](./dump.md)
- [Environment](./environment.md)
- [File](./file.md)
- [Floating Point](./float.md)
- [JSON](./json.md)
- [List Utilities](./list.md)
- [Log](./log.md)
- [Markdown](./markdown.md)
- [Map](./map.md)
- [Network](./network.md)
- [Operating System](./os.md)
- [Process](./process.md)
- [Text](./text.md)
- [Type](./type.md)
- [URL](./url.md)
- [User](./user.md)

## Application Tools

- [Application](./application.md)
- [Build Environment](./build.md)
- [Deploy](./deploy.md)
- [Deployment](./deployment.md)
- [Documentation](./documentation.md)
- [Hook API](./hook.md)
- [Hooks](./hooks.md)
- [Identical](./identical.md)
- [Installation](./install.md)
- [Pipeline](./pipeline.md)
- [Utilities](./utilities.md)
- [Version](./version.md)
- [Web](./web.md)

# Specifications

- [Function interfaces](./interface.md)
- [Internal tools](./internal.md)

# Software Integration

- [Amazon Web Services](./aws.md)
- [BitBucket](./bitbucket.md)
- [brew (HomeBrew)](./brew.md)
- [Crontab](./crontab.md)
- [daemontools](./daemontools.md)
- [Darwin](./darwin.md)
- [Docker](./docker.md)
- [Docker Compose](./docker-compose.md)
- [Git](./git.md)
- [GitHub](./github.md)
- [iTerm2](./iterm2.md)
- [MariaDB](./mariadb.md)
- [Markdown](./markdown.md)
- [Node](./node.md)
- [NPM](./npm.md)
- [PHP](./php.md)
- [rsync](./rsync.md)
- [SSH](./ssh.md)
- [System V Init](./sysvinit.md)
- [Terraform](./terraform.md)
- [OpenTofu](./opentofu.md)
- [Vendor](./vendor.md)
- [XDebug](./xdebug.md)

# Package Managers

Wrappers for these are in [package tools](./package.md).

- [Alpine Package Manager](./apk.md)
- [Apt Package Manager](./apt.md)
- [Homebrew](./brew.md)
- [MacPorts](./macports.md)
- Yum (Future)

We have added platform-generic installation names (see {link:packageGroupInstall}).

# How to include in your scripts

The `tools.sh` shell is the only include you need in your scripts:

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

(see `bin/build/identical/__tools.sh` for an error-reporting loader)

Once included, [all functions here](./all.md) are available for use.
