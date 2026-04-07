# Tools

[All function index](./all.md)

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## Terminal Tools

- [Bash](./bash.md) – Bash user input, loading, parsing, linting
- [Console](./console.md) – Console tools for size, title, outputting links
- [Cursor](./cursor.md) – Tools to moving the cursor around the terminal
- [Decorate](./decorate.md) – Decorating text with colors and styles, color schemes, and decorate extensions
- [Decoration Tools](./decoration.md) – Text decoration tools like bars, boxes, big text

## Development Tools

- [Application](./application.md) – Remember your application home directory upon login
- [Approve](./approve.md) – Interactively load `bash` code (with permission)
- [Binaries (direct)](./bin.md)
- [Completion](./completion.md) – Add completions for Zesk Build
- [Dump](./dump.md) – Dump the environment, files, binary data, or stack information easily and securely.
- [Developer](./developer.md) – Tools for your `developer.sh`
    - [MANPATH](./manpath.md) MANPATH manipulation
    - [PATH](./path.md) – PATH manipulation
    - [Prompt](./prompt.md) – Customize your bash prompt easily, adding project customization and extensible prompt
- [Installer](./installer.md) – Write your own installer scripts for your own software using Zesk Build installation
  tools.
- [Interactive](./interactive.md) – Interactivity tools for user confirmation, menus, message display
- [Linting](./lint.md) – Clean and check your **Bash** code.
  commands.
- [Readline](./readline.md) – Edit `readline` configuration

## Testing

- [Assertion](./assert.md) – Complete assertion and testing toolkit
- [Coverage](./coverage.md) – EXPERIMENTAL. Bash coverage tools.
- [Debug](./debug.md) – Debugger for Bash programs
- [Testing](./test.md) – Testing utilities available while using `testTools`

## Language Tools

- [Argument](./argument.md) – EXPERIMENTAL. Arguments specified using comments.
- [Character](./character.md) – Character manipulation tools
- [Date](./date.md) – Date validation, math, and "now"-related date generation
- [Deprecated](./deprecated.md) – Tools to help you upgrade deprecated code.
- [Floating Point](./float.md) – Simple floating point number manipulation
- [List Utilities](./list.md) – Text-based list manipulation with a separator character
- [Map](./map.md) – Simple token replacement using environment files or variables
- [Quote](./quote.md) – Text quoting tools
- [Text](./text.md) – Text manipulation tools
- [Type](./type.md) – Type testing and tools
- [URL](./url.md) – URL parsing and tools
- [Usage](./usage.md) – Self-documenting functions make life easier.
- [Validate](./validate.md) – Validate any input type with a suite of type validations, extensible.
- [Sugar Core](./sugar-core.md) and [Sugar](./sugar.md) – Syntactic sugar makes code easier to read, debug, and
  understand.

## System Tools

- [Directory](./directory.md) – Directory manipulation tools
- [Diff](./diff.md) – File differencing tools.
- [Environment](./environment.md) – Anything you could need to manipulate, load, modify, or generate environment files.
- [File](./file.md) – File attributes accessors, link tools
- [Group](./group.md) – User group utilities (also [User](./user.md))
- [Fingerprint](./fingerprint.md) – Fingerprint your code
- [Log](./log.md) – Log rotation
- [Network](./network.md) – Basic networking information, host name
- [CPU](cpu.md) – CPU count and load average
- [Services](./service.md) – System services database (`/etc/services`)
- [Process](./process.md) – Process tools
- [Timing](./timing.md) – Millisecond timing support across operating systems
- [User](./user.md) – User database tools (also [Group](./group.md))
- [Watch](./watch.md) – Watch files or directories and take actions

## Formats

- [Environment](./environment.md) – Anything you could need to manipulate, load, modify, or generate environment files.
- [jUnit](./junit.md) – Generate `junit.xml` output for testing (EXPERIMENTAL)
- [JSON](./json.md) – Access and cleaning of JSON
- [Markdown](./markdown.md) – Markdown tools
- [tar](./tar.md) – Tar platform neutral calls
- [URL](./url.md) – URL parsing and tools
- [XML](./xml.md) – XML generation tools
- [mdoc](./mdoc.md) – `mdoc` generation tools (PLANNED)

## Application Tools

- [Build Application Tools](./build.md) – Access to `bin/env` and related cache directories, installation of the
  installer and installer tools.
- [Deploy](./deploy.md) – Application deployment tools for a local environment
- [Deployment](./deployment.md) – Application deployment tools for remote
- [Documentation](./documentation.md) – Bash documentation automatically and beautifully
- [Hook API](./hook.md) – Application hooks let you change behavior across applications.
- [Hooks](./hooks.md) – List of available or known hooks
- [Identical](./identical.md) – A system to keep your code and source in perfect harmony
- [Installation](./install.md) – Install other software like `aws` or `python` using package managers or custom
  techniques.
- [Utilities](./utilities.md) – Some handy utilities
- [Version](./version.md) – Release version management for your application
- [Web](./web.md) – Web tools

# Specifications

- [Function interfaces](./interface.md)
- [Internal tools](./internal.md) – Tools used during development of this project

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
- [mkdocs](./mkdocs.md)
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

We have added platform-generic installation names (see [packageGroupInstall](../tools/package.md#packagegroupinstall)).

# How to include in your scripts

The `tools.sh` shell is the only include you need in your scripts:

    # shellcheck source=/dev/null
    source "${BASH_SOURCE[0]%/*}/../bin/build/tools.sh"

(see `bin/build/identical/__tools.sh` for an error-reporting loader)

Once included, [all functions here](./all.md) are available for use.

# New or Obsolete

- [New uncategorized functions](./todo.md)
- [Obsolete](./unused.md)
