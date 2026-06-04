
## `__BASH_PROMPT_MARKERS`

> **Prompt marker list** &mdash; Bash Prompt escape codes for prompt reporting
> > **Type**: *Array:EmptyString* • **Category**: *Bash Prompt*

List of markers to identify to the terminal location of the prompt. Used by `iTerm2` and, hopefully, other terminal applications.

### See Also

- [iTerm2Init]({rel}tools/iterm2.md#iterm2init) - Add iTerm2 support to console ([source](https://github.com/zesk/build/blob/main/bin/build/tools/iterm2.sh#L828))- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `__BASH_PROMPT_MODULES`

> **Prompt module list** &mdash; List of functions to run each prompt command
> > **Type**: *Array:Callable* • **Category**: *Bash Prompt*

List of modules to run each prompt command.

Manage with `bashPrompt functionName` to add, `bashPrompt --remove functionName` to remove.

Make your functions *really* fast otherwise the shell becomes sluggish. Also try:

    BUILD_DEBUG=bashPrompt

To report on each command and timing.

An automatic reporting occurs when commands exceed 0.3s.

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `__BASH_PROMPT_PREVIOUS`

> **Prompt command previous result** &mdash; Previous result code
> > **Type**: *Array* • **Category**: *Bash Prompt*

Previous result code

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `__BASH_PROMPT_SLOW`

> **Prompt command slow threshold** &mdash; Bash Prompt slow timer
> > **Type**: *PositiveInteger* • **Category**: *Bash Prompt*

Number of milliseconds after which a `bashPrompt` command is considered slow.

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `__BUILD_HAS_TTY`

> **TTY Cached Result** &mdash; Cached value of the availability of `/dev/tty`.
> > **Type**: *Boolean* • **Category**: *Internal*

Cached value of the availability of `/dev/tty`.
Possible values are `true` or `false` or blank.

- `true` - `/dev/tty` appears to be operating without errors
- `false` - `/dev/tty` appears to be disconnected and can not be used

This value is set automatically by `isTTYAvailable` and caches the value using this environment variable to avoid testing again.


## `APACHE_HOME`

> **Apache Home Directory** &mdash; Constant for the Apache configuration home directory.
> > **Type**: *Directory* • **Category**: *Vendor*

Constant for the Apache configuration home directory.


## `APPLICATION_BUILD_DATE`

> **Application Build Date** &mdash; Time when a build was initiated, set upon first invocation
> > **Type**: *String* • **Category**: *Deployment*

Time when a build was initiated, set upon first invocation if not already.


## `APPLICATION_CODE_EXTENSIONS`

> **Application Code File Extension List** &mdash; List of extensions for code in the application. Required.
> > **Type**: *ColonDelimitedList* • **Category**: *Application*

List of extensions for code in the application. Required.


## `APPLICATION_CODE_IGNORE`

> **Application Code Ignore Paths** &mdash; List of path names to ignore for application code. (e.g.
> > **Type**: *ColonDelimitedList* • **Category**: *Application*

List of path names to ignore for application code. (e.g. `/vendor/`, `/node_modules/`, etc.)


## `APPLICATION_CODE`

> **Application Code Name** &mdash; This is the unique code name of the application. Use
> > **Type**: *String* • **Category**: *Application*

This is the unique code name of the application. Use a domain name suffix to ensure global uniqueness.


## `APPLICATION_ID`

> **Application ID** &mdash; This is the unique hash which represents the source code
> > **Type**: *String* • **Category**: *Deployment*

This is the unique hash which represents the source code state (typically a git hash)


## `APPLICATION_JSON_PREFIX`

> **Application JSON Prefix** &mdash; Prefix to place we can store things in the JSON
> > **Type**: *String* • **Category**: *Application*

Prefix to place we can store things in the JSON file (e.g. to set the fingerprint)


## `APPLICATION_JSON`

> **Application JSON File** &mdash; Path to the application configuration JSON
> > **Type**: *ApplicationFile* • **Category**: *Application*

Path to the application configuration JSON


## `APPLICATION_NAME`

> **Application Name** &mdash; This is the display name of the application
> > **Type**: *String* • **Category**: *Application*

This is the display name of the application


## `APPLICATION_OWNER`

> **Application Legal Owner** &mdash; The entity which owns or manages the application. Typically the
> > **Type**: *String* • **Category**: *Application*

The entity which owns or manages the application. Typically the owning company name.
This is used in Copyright notices in code and other locations.


## `APPLICATION_REMOTE_HOME`

> **Application Remote Home Directory** &mdash; Path on the remote server where the application is served
> > **Type**: *RemoteDirectory* • **Category**: *Deployment*

Path on the remote server where the application is served


## `APPLICATION_TAG`

> **Application Tag** &mdash; This is the full version number including debugging or release
> > **Type**: *String* • **Category**: *Deployment*

This is the full version number including debugging or release identifiers


## `APPLICATION_VERSION`

> **Application Version** &mdash; This is the version number which can be displayed
> > **Type**: *String* • **Category**: *Deployment*

This is the version number which can be displayed


## `AWS_ACCESS_KEY_DATE`

> **AWS Access Key Issue Date** &mdash; Date of key expiration which can be checked in pipelines.
> > **Type**: *Date* • **Category**: *Amazon Web Services*

Date of key expiration which can be checked in pipelines.
Not part of the Amazon specification but a good idea to track expiration of keys.


## `AWS_ACCESS_KEY_ID`

> **AWS Access Key** &mdash; Amazon Web Services IAM Identity
> > **Type**: *String* • **Category**: *Amazon Web Services*

Amazon Web Services IAM Identity


## `AWS_PROFILE`

> **AWS Profile** &mdash; Default profile for Amazon Web Services
> > **Type**: *String* • **Category**: *Amazon Web Services*

Default profile for Amazon Web Services


## `AWS_REGION`

> **AWS Region** &mdash; Region for Amazon Web Services
> > **Type**: *String* • **Category**: *Amazon Web Services*

Region for Amazon Web Services

### See Also

- [awsIPAccess]({rel}tools/aws.md#awsipaccess) - Grant access to AWS security group for this IP only using Amazon IAM credentials ([source](https://github.com/zesk/build/blob/main/bin/build/tools/aws.sh#L311))


## `AWS_SECRET_ACCESS_KEY`

> **AWS Secret Access Key** &mdash; Private Secret Password for AWS
> > **Type**: *Secret* • **Category**: *Amazon Web Services*

Private Secret Password for AWS


## `BITBUCKET_CLONE_DIR`

> **Bitbucket Clone Directory** &mdash; Defined in BITBUCKET Pipelines
> > **Type**: *Directory* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines
Typically should match BUILD_HOME


## `BITBUCKET_REPO_SLUG`

> **Bitbucket Repository Slug** &mdash; Defined in BITBUCKET Pipelines, represents the project code name.
> > **Type**: *String* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines, represents the project code name.


## `BITBUCKET_WORKSPACE`

> **Bitbucket Workspace** &mdash; Defined in BITBUCKET Pipelines. represents the project workspace.
> > **Type**: *String* • **Category**: *Continuous Integration*

Defined in BITBUCKET Pipelines. represents the project workspace.


## `BUILD_CACHE_HOME`

> **Build Cache Directory** &mdash; Location for the build system cache files. Defaults to `$HOME/.build`
> > **Type**: *Directory* • **Category**: *Build Configuration*

Location for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build`
Cache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.


## `BUILD_COLORS`

> **Build Colors Flag** &mdash; If true then colors are shown, blank means guess the
> > **Type**: *Boolean* • **Category**: *Decoration*

If true then colors are shown, blank means guess the value, false means no colors

### See Also

- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))


## `BUILD_COMPANY_LINK`

> **Company URL** &mdash; Legal copyright holder website for this codebase
> > **Type**: *URL* • **Category**: *Application*

Legal copyright holder website for this codebase


## `BUILD_COMPANY`

> **Company Name** &mdash; Legal copyright holder for this codebase
> > **Type**: *String* • **Category**: *Application*

Legal copyright holder for this codebase


## `BUILD_COMPOSER_VERSION`

> **Composer Version** &mdash; Version of composer to use for building vendor directory
> > **Type**: *String* • **Category**: *Installation*

Version of composer to use for building vendor directory

### See Also

- [phpComposer]({rel}tools/php.md#phpcomposer) - Run Composer commands on code ([source](https://github.com/zesk/build/blob/main/bin/build/tools/php-composer.sh#L29))


## `BUILD_DEBUG_LINES`

> **Debugging output lines** &mdash; Number of lines of debugging output to send to stderr
> > **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Number of lines of debugging output to send to stderr before stopping


## `BUILD_DEBUG`

> **Debugging Flag** &mdash; Constant for turning debugging on during build to find errors
> > **Type**: *CommaDelimitedList* • **Category**: *Build Configuration*

Constant for turning debugging on during build to find errors in the build scripts.
Enable debugging globally in the build scripts. Set to a comma (`,`) delimited list string to enable specific debugging, or `true` for ALL debugging, `false` (or blank) for NO debugging.


## `BUILD_DEVELOPMENT_HOME`

> **Home for Zesk Build development** &mdash; Directory where Zesk Build is being developed in the file
> > **Type**: *String* • **Category**: *Development*

Directory where Zesk Build is being developed in the file system (for other projects to test against a changed version)

### See Also

- [buildDevelopmentLink]({rel}tools/developer.md#builddevelopmentlink) - Add a development link to the local version of Zesk ([source](https://github.com/zesk/build/blob/main/bin/build/tools/developer.sh#L181))


## `BUILD_DOCKER_IMAGE`

> **Docker Image** &mdash; Default docker image to use when launching `dockerLocalContainer`
> > **Type**: *String* • **Category**: *Docker*

Default docker image to use when launching `dockerLocalContainer`

### See Also

- [dockerLocalContainer]({rel}tools/docker.md#dockerlocalcontainer) - Run a build container using given docker image. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L119))


## `BUILD_DOCKER_PATH`

> **Docker Mapped Path** &mdash; Default path for the shell to map the current directory
> > **Type**: *RemoteDirectory* • **Category**: *Docker*

Default path for the shell to map the current directory to when launching `dockerLocalContainer`

### See Also

- [dockerLocalContainer]({rel}tools/docker.md#dockerlocalcontainer) - Run a build container using given docker image. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L119))


## `BUILD_DOCKER_PLATFORM`

> **Docker Platform** &mdash; The platform for `dockerLocalContainer`
> > **Type**: *String* • **Category**: *Docker*

The platform for `dockerLocalContainer`

Contacts of this can be found via `docker buildx ls`

Valid values are:

- `linux/arm64`
- `linux/amd64`
- `linux/amd64/v2`
- `linux/riscv64`
- `linux/ppc64le`
- `linux/s390x`
- `linux/386`
- `linux/mips64le`
- `linux/mips64`
- `linux/arm/v7`
- `linux/arm/v6`

If not specified, uses the default for the current platform.

### See Also

- [dockerLocalContainer]({rel}tools/docker.md#dockerlocalcontainer) - Run a build container using given docker image. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L119))- [dockerPlatformDefault]({rel}tools/docker.md#dockerplatformdefault) - Fetch the default platform for docker ([source](https://github.com/zesk/build/blob/main/bin/build/tools/docker.sh#L22))


## `BUILD_DOCUMENTATION_PATH`

> **Build Documentation Path List** &mdash; Search path for documentation settings file.
> > **Type**: *DirectoryList* • **Category**: *Bash*

Search path for documentation settings file.
A colon `:` separated list of paths to search for function documentation settings file for `__bashDocumentationCached`

### See Also

- {SEE:__bashDocumentationCached}


## `BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN`

> **Build documentation URL Pattern** &mdash; Links in documentation
> > **Type**: *String* • **Category**: *Documentation*

Links in documentation


## `BUILD_ENVIRONMENT_DIRS`

> **Build Environment Directory List** &mdash; Search directory for environment definition files. `:` separated.
> > **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for environment definition files. `:` separated.
Note these should be *in addition* to the default environment variables ALWAYS located at `./bin/build/env`
THe default is `$(buildHome)/bin/env`. Make sure to append to this as a `:`-list.


## `BUILD_HOME`

> **Build Home Directory** &mdash; `BUILD_HOME` is `.` when this code is installed - at
> > **Type**: *Directory* • **Category**: *Build Configuration*

`BUILD_HOME` is `.` when this code is installed - at `./bin/build`. Usually an absolute path and does NOT end with a trailing slash.
This is computed from the current source file using `${BASH_SOURCE[0]}`.


## `BUILD_HOOK_DIRS`

> **Build Hook Directory List** &mdash; List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`.
> > **Type**: *ApplicationDirectoryList* • **Category**: *Build Configuration*

List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`.
Colon (`:`) separated list.


## `BUILD_HOOK_EXTENSIONS`

> **Build Hook Extension List** &mdash; List of extensions to run when looking for hooks
> > **Type**: *ColonDelimitedList* • **Category**: *Application*

List of extensions to run when looking for hooks


## `BUILD_INSTALL_URL`

> **Build Installation URL** &mdash; `BUILD_INSTALL_URL` for `installInstallBuild` - source URL for a raw installer.
> > **Type**: *URL* • **Category**: *Build Configuration*

`BUILD_INSTALL_URL` for `installInstallBuild` - source URL for a raw installer.


## `BUILD_MAINTENANCE_CREATED_FILE`

> **Maintenance Created Flag** &mdash; When true, means the `.env.local` file was created by the
> > **Type**: *Boolean* • **Category**: *Application*

When true, means the `.env.local` file was created by the maintenance hook and should be deleted when maintenance is
no longer enabled.


## `BUILD_MAINTENANCE_MESSAGE_VARIABLE`

> **Maintenance Variable Message Name** &mdash; Name of the environment variable (if any) which reflects the
> > **Type**: *EnvironmentVariable* • **Category**: *Application*

Name of the environment variable (if any) which reflects the current maintenance message.
Default is `MAINTENANCE_MESSAGE` and this is typically added to the `.env.local` to a live
application. Your application should monitor these files for changes if they are cached and reload as needed to ensure
these messages are displayed immediately.


## `BUILD_MAINTENANCE_VARIABLE`

> **Maintenance Variable Name** &mdash; The maintenance variable name which enables (or disabled) maintenance mode.
> > **Type**: *EnvironmentVariable* • **Category**: *Application*

The maintenance variable name which enables (or disabled) maintenance mode.
Default is `MAINTENANCE`.
This value is set to `true` or `false`


## `BUILD_MAXIMUM_TAGS_PER_VERSION`

> **Maximum Git Tags per Version** &mdash; Number of versions tags (d0, d1, d2, etc.) to look
> > **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Number of versions tags (d0, d1, d2, etc.) to look for before giving up in `gitTagVersion`

### See Also

- [gitTagVersion]({rel}tools/git.md#gittagversion) - Generates a git tag for a build version, so \`v1.0d1\`, ([source](https://github.com/zesk/build/blob/main/bin/build/tools/git.sh#L336))


## `BUILD_NOTIFY_SOUND`

> **Notification Sound** &mdash; Sound for notifications. Set to `-` for no sound. Defaults
> > **Type**: *String* • **Category**: *Build Configuration*

Sound for notifications. Set to `-` for no sound. Defaults to `zesk-build-notification`.

### See Also

- [darwinNotification]({rel}tools/darwin.md#darwinnotification) - Display a notification for the user ([source](https://github.com/zesk/build/blob/main/bin/build/tools/darwin.sh#L127))


## `BUILD_NPM_VERSION`

> **npm Version** &mdash; Version of npm to install using native `npm` binary.
> > **Type**: *String* • **Category**: *Installation*

Version of npm to install using native `npm` binary.

### See Also

- [npmInstall]({rel}tools/install.md#npminstall) - Install NPM in the build environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/npm.sh#L19))


## `BUILD_PACKAGE_MANAGER`

> **Package Manager Binary** &mdash; The default package manager on systems which have more than
> > **Type**: *Executable* • **Category**: *Installation*

The default package manager on systems which have more than one package manager available.


## `BUILD_PAIR_WIDTH`

> **Pair Width** &mdash; Width for pairs. Defaults to `40`.
> > **Type**: *PositiveInteger* • **Category**: *Decoration*

Width for pairs. Defaults to `40`.

### See Also

- {SEE:__decorateExtensionPair}


## `BUILD_PRECOMMIT_EXTENSIONS`

> **Pre-Commit Extension List** &mdash; List of extensions for which build hooks may be written
> > **Type**: *List* • **Category**: *Build Configuration*

List of extensions for which build hooks may be written and run.
Presence in this list simply means it may run, not that it is written or runs; add your own
`bin/hooks/pre-commit-XXX.sh` to handle a specific file type in your application.

Currently:

- `sh` - Bash
- `PHP` - PHP
- `js` - JavaScript
- `json` - JSON
- `md` - Markdown
- `yml` - Yet Another Markup Language
- `txt` - Text files
- `py` - Python
- `go` - Golang
- `rs` - Rust
- `css` - CSS
- `less`, `sass`, `scss` - Compiled stylesheets


## `BUILD_PROJECT_DEACTIVATE`

> **Project Deactivation Function** &mdash; Set this to a function which cleans up the project
> > **Type**: *Function* • **Category**: *Application*

Set this to a function which cleans up the project context and
will be run on `project-deactivate` hook which is sourced.


## `BUILD_PROMPT_COLORS`

> **Prompt Color List** &mdash; Colon-separated list of colors for the prompt
> > **Type**: *ColonDelimitedList* • **Category**: *Decoration*

Colon-separated list of colors for the prompt

Colors are escape codes. Last entry is a reset simply to make environment output less messy.

1. Success color
2. Failure color
3. User
4. Host
5. Path

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `BUILD_RELEASE_NOTES`

> **Release Notes Application Path** &mdash; Constant for the release notes path. Defaults to `./docs/release`.
> > **Type**: *ApplicationDirectory* • **Category**: *Build Configuration*

Constant for the release notes path. Defaults to `./docs/release`.


## `BUILD_TARGET`

> **Build Application Target File Name** &mdash; The file to generate when generating builds
> > **Type**: *String* • **Category**: *Deployment*

The file to generate when generating builds


## `BUILD_TERM_COLORS_STATE`

> **Terminal Color State** &mdash; State to store state of current terminal color state
> > **Type**: *String* • **Category**: *Application*

State to store state of current terminal color state

### See Also

- [bashPromptModule_TermColors]({rel}tools/prompt.md#bashpromptmodule_termcolors) - Terminal colors to match projects ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L247))


## `BUILD_TEST_FLAGS`

> **Test Flags** &mdash; Test flags affect controls and how tests are run.
> > **Type**: *String* • **Category**: *Testing*

Test flags affect controls and how tests are run.


## `BUILD_TEXT_BINARY`

> **Text Executable** &mdash; Binary used to generate `decorate big`
> > **Type**: *Callable* • **Category**: *Decoration*

Binary used to generate `decorate big`

### See Also

- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89)){SEE:big}
- {SEE:__aptStandardPackages}
- {SEE:__apkStandardPackages}
- {SEE:__brewStandardPackages}


## `BUILD_TIMESTAMP`

> **Build Timestamp** &mdash; Time when a build was initiated, set upon first invocation
> > **Type**: *UnsignedInteger* • **Category**: *Deployment*

Time when a build was initiated, set upon first invocation if not already


## `BUILD_URL_BINARY`

> **URL Executable** &mdash; Binary used in __urlOpen
> > **Type**: *Callable* • **Category**: *Decoration*

Binary used in __urlOpen

### See Also

- [urlOpen]({rel}tools/url.md#urlopen) - Open a URL using the operating system ([source](https://github.com/zesk/build/blob/main/bin/build/tools/url.sh#L419))


## `BUILD_URL_TIMEOUT`

> **URL Timeout** &mdash; Timeout in seconds for fetching URLs in `urlFetch`
> > **Type**: *PositiveInteger* • **Category**: *Build Configuration*

Timeout in seconds for fetching URLs in `urlFetch`

### See Also

- [urlFetch]({rel}tools/url.md#urlfetch) - Fetch URL content ([source](https://github.com/zesk/build/blob/main/bin/build/tools/url.sh#L559))


## `BUILD_VERSION_NO_OPEN`

> **Build Version No Open Flag** &mdash; Constant for whether to open release notes when a version
> > **Type**: *Boolean* • **Category**: *Build Configuration*

Constant for whether to open release notes when a version is requested (see `version-already`)


## `BUILD_VERSION_SUFFIX`

> **Build Version Suffix** &mdash; Default suffix used in `gitTagVersion`
> > **Type**: *String* • **Category**: *Build Configuration*

Default suffix used in `gitTagVersion`

### See Also

- [gitTagVersion]({rel}tools/git.md#gittagversion) - Generates a git tag for a build version, so \`v1.0d1\`, ([source](https://github.com/zesk/build/blob/main/bin/build/tools/git.sh#L336))


## `BUILD_YARN_VERSION`

> **Yarn Version** &mdash; Version of yarn to install using `corepack`
> > **Type**: *String* • **Category**: *Vendor*

Version of yarn to install using `corepack`

### See Also

- [yarnInstall]({rel}tools/node.md#yarninstall) - Install yarn ([source](https://github.com/zesk/build/blob/main/bin/build/tools/yarn.sh#L24))


## `CI`

> **Continuous Integration** &mdash; If this value is non-blank, then console `statusMessage`s are just
> > **Type**: *String* • **Category**: *Continuous Integration*

If this value is non-blank, then console `statusMessage`s are just output normally.
Continuous Integration - this is set to a non-blank value in:

- Bitbucket pipelines

### See Also

- [statusMessage]({rel}tools/decorate.md#statusmessage) - Output a status message and display correctly on consoles with animation and in log files ([source](https://github.com/zesk/build/blob/main/bin/build/tools/colors.sh#L316))- [consoleHasAnimation]({rel}tools/decorate.md#consolehasanimation) - Does the console support animation? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/colors.sh#L55))


## `COLORFGBG`

> **Terminal Foreground and Background** &mdash; Standard way to express the foreground and background colors
> > **Type**: *String* • **Category**: *Decoration*

Standard way to express the foreground and background colors

- `foregroundColor` - UnsignedInteger. 0 to 16
- `backgroundColor` - UnsignedInteger. 0 to 16

Not referenced in this product; referenced via [rxvt](https://rxvt.sourceforge.net/) and may be honored at some point.


## `DAEMONTOOLS_HOME`

> **Daemontools Home** &mdash; Constant for the directory where services are monitored by daemontools
> > **Type**: *Directory* • **Category**: *Vendor*

Constant for the directory where services are monitored by daemontools


## `DEPLOY_REMOTE_HOME`

> **Remote directory for deployment** &mdash; Path on the remote server where the application deployment home
> > **Type**: *RemoteDirectory* • **Category**: *Deployment*

Path on the remote server where the application deployment home is (per application)


## `DEPLOY_USER_HOSTS`

> **Host list for deployment** &mdash; A list of one ore more user@host for installation of
> > **Type**: *String* • **Category**: *Deployment*

A list of one ore more user@host for installation of the application

### See Also

- [deployApplication]({rel}tools/deploy.md#deployapplication) - Deploy an application from a deployment repository ([source](https://github.com/zesk/build/blob/main/bin/build/tools/deploy.sh#L43))


## `DEPLOYMENT`

> **Deployment Code** &mdash; Target deployment for this code
> > **Type**: *String* • **Category**: *Deployment*

Target deployment for this code


## `DISPLAY`

> **X Display** &mdash; Environment variable for X windows display.
> > **Type**: *String* • **Category**: *Bash*

Environment variable for X windows display.
From the user's perspective, every X server has a display name of the form: `hostname:displaynumber.screennumber`


## `EDITOR`

> **Editor Command** &mdash; Binary for editing files
> > **Type**: *Callable* • **Category**: *Bash*

Binary for editing files


## `GIT_OPEN_LINKS`

> **Git Open Links Flag** &mdash; Open links from git remotes in `gitCommit`
> > **Type**: *Boolean* • **Category**: *Development*

Open links from git remotes in `gitCommit`

### See Also

- [gitCommit]({rel}tools/git.md#gitcommit) - Commits all files added to git and also update release ([source](https://github.com/zesk/build/blob/main/bin/build/tools/git.sh#L462))- [gitCommit]({rel}tools/git.md#gitcommit) - Commits all files added to git and also update release ([source](https://github.com/zesk/build/blob/main/bin/build/tools/git.sh#L462))


## `GITHUB_ACCESS_TOKEN_EXPIRE`

> **GitHub Access Token Expiration Date** &mdash; GitHub Access token expiration date. Invalid AFTER this date.
> > **Type**: *Date* • **Category**: *Development*

GitHub Access token expiration date. Invalid AFTER this date.

### See Also

- [githubRelease]({rel}tools/github.md#githubrelease) - Generate a release on GitHub using API ([source](https://github.com/zesk/build/blob/main/bin/build/tools/github.sh#L184))


## `GITHUB_ACCESS_TOKEN`

> **GitHub Access Token** &mdash; Access token used for release
> > **Type**: *Secret* • **Category**: *Development*

Access token used for release

### See Also

- [githubRelease]({rel}tools/github.md#githubrelease) - Generate a release on GitHub using API ([source](https://github.com/zesk/build/blob/main/bin/build/tools/github.sh#L184))


## `GITHUB_REPOSITORY_NAME`

> **GitHub Repository Name** &mdash; Repository name for release
> > **Type**: *String* • **Category**: *Development*

Repository name for release

### See Also

- [githubRelease]({rel}tools/github.md#githubrelease) - Generate a release on GitHub using API ([source](https://github.com/zesk/build/blob/main/bin/build/tools/github.sh#L184))


## `GITHUB_REPOSITORY_OWNER`

> **GitHub Repository Owner** &mdash; Repository owner for release
> > **Type**: *String* • **Category**: *Deployment: GitHub*

Repository owner for release

### See Also

- [githubRelease]({rel}tools/github.md#githubrelease) - Generate a release on GitHub using API ([source](https://github.com/zesk/build/blob/main/bin/build/tools/github.sh#L184))


## `HOME`

> **User Home** &mdash; Current user's home directory.
> > **Type**: *Directory* • **Category**: *Bash*

Current user's home directory.


## `IP_URL_FILTER`

> **Filter for IP Lookup** &mdash; jq filter to parse IP_URL result (assuming JSON)
> > **Type**: *String* • **Category**: *Build Configuration*

jq filter to parse IP_URL result (assuming JSON)
if blank, no filter is used and raw result is returned

### See Also

- [networkIPLookup]({rel}tools/network.md#networkiplookup) - Get the current IP address of a host ([source](https://github.com/zesk/build/blob/main/bin/build/tools/network.sh#L75))


## `IP_URL`

> **IP Lookup URL** &mdash; URL to look up IP my address remotely
> > **Type**: *URL* • **Category**: *Build Configuration*

URL to look up IP my address remotely

### See Also

- [networkIPLookup]({rel}tools/network.md#networkiplookup) - Get the current IP address of a host ([source](https://github.com/zesk/build/blob/main/bin/build/tools/network.sh#L75))


## `LC_TERMINAL`

> **Terminal Application** &mdash; LC_TERMINAL typically identifies the terminal application
> > **Type**: *String* • **Category**: *Bash*

LC_TERMINAL typically identifies the terminal application


## `MANPATH`

> **Manual Pages Path** &mdash; A colon `:` separated list of paths to search for
> > **Type**: *DirectoryList* • **Category**: *Bash*

A colon `:` separated list of paths to search for manual pages.
See [`manPathConfigure`](/tools/platform/#manpathconfigure)

### See Also

- [manPathConfigure]({rel}tools/manpath.md#manpathconfigure) - Modify the MANPATH environment variable to add a path. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/manpath.sh#L16))


## `MARIADB_BINARY_CONNECT`

> **mariadb Connect Executable** &mdash; MariaDB binary for database connections
> > **Type**: *Executable* • **Category**: *Vendor*

MariaDB binary for database connections


## `MARIADB_BINARY_DUMP`

> **mariadb Dump Executable** &mdash; MariaDB binary for dump
> > **Type**: *Executable* • **Category**: *Vendor*

MariaDB binary for dump


## `NODE_PACKAGE_MANAGER`

> **node Package Manager** &mdash; The package manager used for node operations. Usually `yarn` or
> > **Type**: *Executable* • **Category**: *Vendor*

The package manager used for node operations. Usually `yarn` or `npm`.
Default is `yarn`.


## `PATH`

> **Executable Search Path** &mdash; A colon `:` separated list of paths to search for
> > **Type**: *DirectoryList* • **Category**: *Bash*

A colon `:` separated list of paths to search for executables in `bash`.
See [`pathConfigure`](/tools/platform/#pathconfigure)

### See Also

- [pathConfigure]({rel}tools/path.md#pathconfigure) - Modify the PATH environment variable to add a path. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/path.sh#L48))


## `PRODUCTION`

> **Production Flag** &mdash; Is this a production system? e.g. remove unnecessary runtime checks.
> > **Type**: *Boolean* • **Category**: *Bash*

Is this a production system? e.g. remove unnecessary runtime checks.


## `PROMPT_COMMAND`

> **Prompt function** &mdash; Command is run before displaying the prompt, receives exit status
> > **Type**: *Callable* • **Category**: *Bash*

Command is run before displaying the prompt, receives exit status from the prior command.

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `PS1`

> **Bash Command Prompt** &mdash; Bash Prompt for terminals
> > **Type**: *String* • **Category**: *Bash*

Bash Prompt for terminals

### See Also

- [bashPrompt]({rel}tools/prompt.md#bashprompt) - Bash prompt toolkit ([source](https://github.com/zesk/build/blob/main/bin/build/tools/prompt.sh#L82))


## `SHFMT_ARGUMENTS`

> **Shell Formatting Arguments** &mdash; Arguments passed to shfmt when running as a pre-commit hook
> > **Type**: *Array* • **Category**: *Bash*

Arguments passed to shfmt when running as a pre-commit hook

### See Also

- {SEE:pre-commit-sh.sh}


## `TERM`

> **Terminal Type** &mdash; The current terminal type.
> > **Type**: *String* • **Category**: *Bash*

The current terminal type.


## `TEST_TRACK_ASSERTIONS`

> **Track Assertions Flag** &mdash; Assertion tracking testing optimization
> > **Type**: *Boolean* • **Category**: *Testing*

Assertion tracking testing optimization
Turn on or off tracking of function assertions within the testing core.
If blank, the default behavior is to track; disable it with setting the value to `false`.


## `VISUAL`

> **File Preview** &mdash; Binary for viewing files
> > **Type**: *Executable* • **Category**: *Bash*

Binary for viewing files


## `XDEBUG_ENABLED`

> **xDebug Enabled Flag** &mdash; Is xdebug enabled? The application can honor this environment variable
> > **Type**: *Boolean* • **Category**: *PHP*

Is xdebug enabled? The application can honor this environment variable to automatically connect to the debugger.

### See Also

- [github.com](https://github.com/zesk/zesk/blob/master/xdebug.php)


## `XDG_CACHE_HOME`

> **Main Cache Directory** &mdash; Main Cache Directory
> > **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific cache data to be stored
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.


## `XDG_CONFIG_DIRS`

> **Configuration Path Directories** &mdash; Configuration Path Directories
> > **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for user-specific configuration files to be stored. `:` separated.
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.


## `XDG_CONFIG_HOME`

> **Main Configuration Path** &mdash; Main Configuration Path
> > **Type**: *Directory* • **Category**: *Build Configuration*

Location for configuration files
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.


## `XDG_DATA_DIRS`

> **Data Path Directories** &mdash; Data Path Directories
> > **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for user-specific data files to be stored. `:` separated.
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.


## `XDG_DATA_HOME`

> **Data Home Directory** &mdash; Data Home Directory
> > **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific data to be stored.
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.


## `XDG_STATE_HOME`

> **State Home Directory** &mdash; State Home Directory
> > **Type**: *Directory* • **Category**: *Build Configuration*

Base directory for user-specific state files to be stored
See [basedir-spec](https://specifications.freedesktop.org/basedir-spec/latest/) for explanation of this and other related environment variables.

