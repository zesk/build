# Tools

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## Shell Tools

- [Approve](./approve.md)
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
- [Sugar Core](./sugar-core.md) and [Sugar](./sugar.md)

## System Tools

- [Character](./character.md)
- [Directory](./directory.md)
- [Date](./date.md)
- [Dump](./dump.md)
- [Environment](./environment.md)
- [File](./file.md)
- [Floating Point](./float.md)
- [Group](./group.md)
- [Host](./host.md)
- [Fingerprint](./fingerprint.md)
- [List Utilities](./list.md)
- [Log](./log.md)
- [Map](./map.md)
- [Network](./network.md)
- [Platform](./platform.md)
- [Process](./process.md)
- [Quote](./quote.md)
- [sed](./sed.md)
- [Text](./text.md)
- [Timing](./timing.md)
- [Type](./type.md)
- [URL](./url.md)
- [User](./user.md)
- [Watch](./watch.md)

## Formats

- [jUnit](./junit.md)
- [JSON](./json.md)
- [Markdown](./markdown.md)
- [tar](./tar.md)
- [XML](./xml.md)

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
- [pcregrep](./pcregrep.md)
- [PHP](./php.md)
- [Python](./python.md)
- [rsync](./rsync.md)
- [SSH](./ssh.md)
- [System V Init](./sysvinit.md)
- [Terraform](./terraform.md)
- [OpenTofu](./tofu.md)
- [Vendor](./vendor.md)
- [XDebug](./xdebug.md)

# Package Managers

Wrappers for these are in [package tools](./package.md).

- [Alpine Package Manager](./apk.md)
- [Apt Package Manager](./apt.md)
- [Homebrew](./brew.md)
- [MacPorts](./macports.md)
- [Yum](./yum.md) (Future)

We have added platform-generic installation names (see {link:packageGroupInstall}).

# How to include in your scripts

The `tools.sh` shell is the only include you need in your scripts:

    # shellcheck source=/dev/null
    . ./bin/build/tools.sh

(see `bin/build/identical/__tools.sh` for an error-reporting loader)

Once included, [all functions here](./all.md) are available for use.

# New or Obsolete

- [Obsolete](./unused.md)
- [New uncategorized functions](./todo.md)