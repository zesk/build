## Additional Details on Environment Variables


## `__BASH_PROMPT_MARKERS`

> **Type**: *Array* • **Category**: *Bash Prompt*

List of markers to identify to the terminal location of the prompt

## `__BASH_PROMPT_MODULES`

> **Type**: *Array* • **Category**: *Bash Prompt*

List of modules to run each prompt command

## `__BASH_PROMPT_PREVIOUS`

> **Type**: *Array* • **Category**: *Bash Prompt*

Previous result code

## `__BUILD_HAS_TTY`

> **Type**: *Boolean* • **Category**: *Internal*

Cached value of the availability of `/dev/tty`.

## `APACHE_HOME`

> **Type**: *Directory* • **Category**: *Vendor*

Constant for the Apache configuration home directory.

## `APPLICATION_BUILD_DATE`

> **Type**: *Date* • **Category**: *Deployment*

Time when a build was initiated, set upon first invocation if not already.

## `APPLICATION_CODE_EXTENSIONS`

> **Type**: *ColonDelimitedList* • **Category**: *Application*

List of extensions for code in the application. Required.

## `APPLICATION_CODE_IGNORE`

> **Type**: *ColonDelimitedList* • **Category**: *Application*

List of path names to ignore for application code. (e.g. `/vendor/`, `/node_modules/`, etc.)

## `APPLICATION_CODE`

> **Type**: *String* • **Category**: *Application*

This is the unique code name of the application. Use a domain name suffix to ensure global uniqueness.

## `APPLICATION_ID`

> **Type**: *String* • **Category**: *Deployment*

This is the unique hash which represents the source code state (typically a git hash)

## `APPLICATION_JSON_PREFIX`

> **Type**: *String* • **Category**: *Application*

Prefix to place we can store things in the JSON file (e.g. to set the fingerprint)

## `APPLICATION_JSON`

> **Type**: *ApplicationFile* • **Category**: *Application*

Path to the application configuration JSON

## `APPLICATION_NAME`

> **Type**: *String* • **Category**: *Application*

This is the display name of the application

## `APPLICATION_OWNER`

> **Type**: *String* • **Category**: *Application*

The entity which owns or manages the application. Typically the owning company name. This is used in Copyright notices in code and other locations.

## `APPLICATION_REMOTE_HOME`

> **Type**: *RemoteDirectory* • **Category**: *Deployment*

Path on the remote server where the application is served

## `APPLICATION_TAG`

> **Type**: *String* • **Category**: *Deployment*

This is the full version number including debugging or release identifiers

## `APPLICATION_VERSION`

> **Type**: *String* • **Category**: *Deployment*

This is the version number which can be displayed

## `AWS_ACCESS_KEY_DATE`

> **Type**: *Date* • **Category**: *Amazon Web Services*

Date of key expiration which can be checked in pipelines. Not part of the Amazon specification but a good idea to track expiration of keys.

## `AWS_ACCESS_KEY_ID`

> **Type**: *String* • **Category**: *Amazon Web Services*

Amazon Web Services IAM Identity

## `AWS_PROFILE`

> **Type**: *String* • **Category**: *Amazon Web Services*

Default profile for Amazon Web Services

## `AWS_REGION`

> **Type**: *String* • **Category**: *Amazon Web Services*

Region for Amazon Web Services

## `AWS_SECRET_ACCESS_KEY`

> **Type**: *Secret* • **Category**: *Amazon Web Services*

Private Secret Password for AWS

## `BITBUCKET_CLONE_DIR`

> **Type**: *Directory* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines Typically should match BUILD_HOME

## `BITBUCKET_REPO_SLUG`

> **Type**: *String* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines, represents the project code name.

## `BITBUCKET_WORKSPACE`

> **Type**: *String* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines. represents the project workspace.

## `BUILD_CACHE_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

Location for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build` Cache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.

## `BUILD_COLORS`

> **Type**: *Boolean* • **Category**: *Decoration*

If true then colors are shown, blank means guess the value, false means no colors

## `BUILD_COMPANY_LINK`

> **Type**: *URL* • **Category**: *Application*

Legal copyright holder website for this codebase

## `BUILD_COMPANY`

> **Type**: *String* • **Category**: *Application*

Legal copyright holder for this codebase

## `BUILD_COMPOSER_VERSION`

> **Type**: *String* • **Category**: *Installation*

Version of composer to use for building vendor directory

## `BUILD_DEBUG_LINES`

> **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Number of lines of debugging output to send to stderr before stopping

## `BUILD_DEBUG`

> **Type**: *CommaDelimitedList* • **Category**: *Build Configuration*

Constant for turning debugging on during build to find errors in the build scripts. Enable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.

## `BUILD_DEVELOPMENT_HOME`

> **Type**: *String* • **Category**: *Development*

Directory where Zesk Build is being developed in the file system (for other projects to test against a changed version)

## `BUILD_DOCKER_BITBUCKET_IMAGE`

> **Type**: *String* • **Category**: *Continuous Integration*



## `BUILD_DOCKER_BITBUCKET_PATH`

> **Type**: *RemoteDirectory* • **Category**: *Continuous Integration*



## `BUILD_DOCKER_IMAGE`

> **Type**: *String* • **Category**: *Docker*

Default docker image to use when launching `dockerLocalContainer`

## `BUILD_DOCKER_PATH`

> **Type**: *RemoteDirectory* • **Category**: *Docker*

Default path for the shell to map the current directory to when launching `dockerLocalContainer`

## `BUILD_DOCKER_PLATFORM`

> **Type**: *String* • **Category**: *Docker*



## `BUILD_DOCUMENTATION_PATH`

> **Type**: *DirectoryList* • **Category**: *Bash*

Search path for documentation settings file. A colon `:` separated list of paths to search for function documentation settings file for `__bashDocumentationCached`

## `BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN`

> **Type**: *String* • **Category**: *Documentation*

Links in documentation

## `BUILD_ENVIRONMENT_DIRS`

> **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for environment definition files. `:` separated.

## `BUILD_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

`BUILD_HOME` is `.` when this code is installed - at `./bin/build`. Usually an absolute path and does NOT end with a trailing slash. This is computed from the current source file using `${BASH_SOURCE[0]}`.

## `BUILD_HOOK_DIRS`

> **Type**: *ApplicationDirectoryList* • **Category**: *Build Configuration*

List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`. Colon (`:`) separated list.

## `BUILD_HOOK_EXTENSIONS`

> **Type**: *ColonDelimitedList* • **Category**: *Application*

List of extensions to run when looking for hooks

## `BUILD_INSTALL_URL`

> **Type**: *URL* • **Category**: *Build Configuration*

`BUILD_INSTALL_URL` for `installInstallBuild` - source URL for a raw installer.

## `BUILD_INTERACTIVE_REFRESH`

> **Type**: *PositiveInteger* • **Category**: *Build Configuration*

When displaying content interactively, how many seconds should elapse before refreshing content?

## `BUILD_MAINTENANCE_CREATED_FILE`

> **Type**: *Boolean* • **Category**: *Application*

When true, means the `.env.local` file was created by the maintenance hook and should be deleted when maintenance is no longer enabled.

## `BUILD_MAINTENANCE_MESSAGE_VARIABLE`

> **Type**: *EnvironmentVariable* • **Category**: *Application*

Name of the environment variable (if any) which reflects the current maintenance message.

## `BUILD_MAINTENANCE_VARIABLE`

> **Type**: *EnvironmentVariable* • **Category**: *Application*

The maintenance variable name which enables (or disabled) maintenance mode.

## `BUILD_MAXIMUM_TAGS_PER_VERSION`

> **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `gitTagVersion`

## `BUILD_NOTIFY_SOUND`

> **Type**: *String* • **Category**: *Build Configuration*

Sound for notifications. Set to `-` for no sound. Defaults to `zesk-build-notification`.

## `BUILD_NPM_VERSION`

> **Type**: *String* • **Category**: *Installation*

Version of npm to install using native `npm` binary.

## `BUILD_PACKAGE_MANAGER`

> **Type**: *Executable* • **Category**: *Installation*

The default package manager on systems which have more than one package manager available.

## `BUILD_PAIR_WIDTH`

> **Type**: *PositiveInteger* • **Category**: *Decoration*

Width for pairs. Defaults to `40`.

## `BUILD_PRECOMMIT_EXTENSIONS`

> **Type**: *List* • **Category**: *Build Configuration*

List of extensions for which build hooks may be written and run.

## `BUILD_PROJECT_DEACTIVATE`

> **Type**: *Function* • **Category**: *Application*

Set this to a function which cleans up the project context and will be run on `project-deactivate` hook which is sourced.

## `BUILD_PROMPT_COLORS`

> **Type**: *ColonDelimitedList* • **Category**: *Decoration*

Colon-separated list of colors for the prompt

## `BUILD_RELEASE_NOTES`

> **Type**: *ApplicationDirectory* • **Category**: *Build Configuration*

Constant for the release notes path. Defaults to `./docs/release`.

## `BUILD_TARGET`

> **Type**: *String* • **Category**: *Deployment*

The file to generate when generating builds

## `BUILD_TERM_COLORS_STATE`

> **Type**: *String* • **Category**: *Application*

State to store state of current terminal color state

## `BUILD_TEST_FLAGS`

> **Type**: *String* • **Category**: *Testing*

Test flags affect controls and how tests are run.

## `BUILD_TEXT_BINARY`

> **Type**: *Callable* • **Category**: *Decoration*

Binary used to generate `decorate big`

## `BUILD_TIMESTAMP`

> **Type**: *Integer* • **Category**: *Deployment*

Time when a build was initiated, set upon first invocation if not already

## `BUILD_URL_BINARY`

> **Type**: *Callable* • **Category**: *Decoration*

Binary used in __urlOpen

## `BUILD_URL_TIMEOUT`

> **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Timeout in seconds for fetching URLs in `urlFetch`

## `BUILD_VERSION_NO_OPEN`

> **Type**: *Boolean* • **Category**: *Build Configuration*

Constant for whether to open release notes when a version is requested (see `version-already`)

## `BUILD_VERSION_SUFFIX`

> **Type**: *String* • **Category**: *Build Configuration*

Default suffix used in `gitTagVersion`

## `BUILD_YARN_VERSION`

> **Type**: *String* • **Category**: *Vendor*

Version of yarn to install using `corepack`

## `CI`

> **Type**: *String* • **Category**: *Continuous Integration*

If this value is non-blank, then console `statusMessage`s are just output normally.

## `COLORFGBG`

> **Type**: *String* • **Category**: *Decoration*

Standard way to express the foreground and background colors

## `DAEMONTOOLS_HOME`

> **Type**: *Directory* • **Category**: *Vendor*

Constant for the directory where services are monitored by daemontools

## `DEPLOY_REMOTE_HOME`

> **Type**: *RemoteDirectory* • **Category**: *Deployment*

Path on the remote server where the application deployment home is (per application)

## `DEPLOY_USER_HOSTS`

> **Type**: *String* • **Category**: *Deployment*

A list of one ore more user@host for installation of the application

## `DEPLOYMENT`

> **Type**: *String* • **Category**: *Deployment*

Target deployment for this code

## `DISPLAY`

> **Type**: *String* • **Category**: *Bash*

Environment variable for X windows display. From the user's perspective, every X server has a display name of the form: `hostname:displaynumber.screennumber`

## `EDITOR`

> **Type**: *Callable* • **Category**: *Bash*

Binary for editing files

## `GIT_BRANCH_FORMAT`

> **Type**: *String* • **Category**: *Development*



## `GIT_OPEN_LINKS`

> **Type**: *Boolean* • **Category**: *Development*

Open links from git remotes in `gitCommit`

## `GIT_REMOTE`

> **Type**: *String* • **Category**: *Development*



## `GITHUB_ACCESS_TOKEN_EXPIRE`

> **Type**: *Date* • **Category**: *Development*

GitHub Access token expiration date. Invalid AFTER this date.

## `GITHUB_ACCESS_TOKEN`

> **Type**: *String* • **Category**: *Development*

Access token used for release

## `GITHUB_REPOSITORY_NAME`

> **Type**: *String* • **Category**: *Development*

Repository name for release

## `GITHUB_REPOSITORY_OWNER`

> **Type**: *String* • **Category**: *Deployment*

Repository owner for release

## `HOME`

> **Type**: *Directory* • **Category**: *Bash*

Current user's home directory.

## `IP_URL_FILTER`

> **Type**: *String* • **Category**: *Build Configuration*

jq filter to parse IP_URL result (assuming JSON) if blank, no filter is used and raw result is returned

## `IP_URL`

> **Type**: *URL* • **Category**: *Build Configuration*

URL to look up IP my address remotely

## `LC_TERMINAL`

> **Type**: *String* • **Category**: *Bash*

LC_TERMINAL typically identifies the terminal application

## `MANPATH`

> **Type**: *DirectoryList* • **Category**: *Bash*

A colon `:` separated list of paths to search for manual pages. See [`manPathConfigure`](/tools/platform/#manpathconfigure)

## `MARIADB_BINARY_CONNECT`

> **Type**: *Executable* • **Category**: *Vendor*

MariaDB binary for database connections

## `MARIADB_BINARY_DUMP`

> **Type**: *Executable* • **Category**: *Vendor*

MariaDB binary for dump

## `NODE_PACKAGE_MANAGER`

> **Type**: *Executable* • **Category**: *Vendor*

The package manager used for node operations. Usually `yarn` or `npm`. Default is `yarn`.

## `PATH`

> **Type**: *DirectoryList* • **Category**: *Bash*

A colon `:` separated list of paths to search for executables in `bash`. See [`pathConfigure`](/tools/platform/#pathconfigure)

## `PRODUCTION`

> **Type**: *Boolean* • **Category**: *Bash*

Is this a production system? e.g. remove unnecessary runtime checks.

## `PROMPT_COMMAND`

> **Type**: *Callable* • **Category**: *Bash*

Command is run prior to displaying the prompt, receives exit status from prior command

## `PS1`

> **Type**: *String* • **Category**: *Bash*

Bash Prompt for terminals

## `SHFMT_ARGUMENTS`

> **Type**: *Array* • **Category**: *Bash*

Arguments passed to shfmt when running as a pre-commit hook

## `TERM`

> **Type**: *String* • **Category**: *Bash*

The current terminal type.

## `TEST_TRACK_ASSERTIONS`

> **Type**: *Boolean* • **Category**: *Testing*

Turn on or off tracking of function assertions within the testing core. If blank, the default behavior is to track; disable it with setting the value to `false`.

## `VISUAL`

> **Type**: *Executable* • **Category**: *Bash*

Binary for viewing files

## `XDEBUG_ENABLED`

> **Type**: *Boolean* • **Category**: *PHP*

Is xdebug enabled? The application can honor this environment variable to automatically connect to the debugger.

## `XDG_CACHE_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific cache data to be stored

## `XDG_CONFIG_DIRS`

> **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for user-specific configuration files to be stored. `:` separated.

## `XDG_CONFIG_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

Location for configuration files

## `XDG_DATA_DIRS`

> **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for user-specific data files to be stored. `:` separated.

## `XDG_DATA_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific data to be stored

## `XDG_STATE_HOME`

> **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific state files to be stored
<!-- end of more stuff -->