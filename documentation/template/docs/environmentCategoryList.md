## Amazon Web Services

- `AWS_ACCESS_KEY_DATE` &mdash; AWS Access Key Issue Date *Date*. Date of key expiration which can be checked in pipelines. [notes](#aws_access_key_date)
- `AWS_ACCESS_KEY_ID` &mdash; AWS Access Key *String*. Amazon Web Services IAM Identity [notes](#aws_access_key_id)
- `AWS_PROFILE` &mdash; AWS Profile *String*. Default profile for Amazon Web Services [notes](#aws_profile)
- `AWS_REGION` &mdash; AWS Region *String*. Region for Amazon Web Services [notes](#aws_region)
- `AWS_SECRET_ACCESS_KEY` &mdash; AWS Secret Access Key *Secret*. Private Secret Password for AWS [notes](#aws_secret_access_key)

## Application

- `APPLICATION_CODE` &mdash; Application Code Name *String*. This is the unique code name of the application. Use [notes](#application_code)
- `APPLICATION_CODE_EXTENSIONS` &mdash; Application Code File Extension List *ColonDelimitedList*. List of extensions for code in the application. Required. [notes](#application_code_extensions)
- `APPLICATION_CODE_IGNORE` &mdash; Application Code Ignore Paths *ColonDelimitedList*. List of path names to ignore for application code. (e.g. [notes](#application_code_ignore)
- `APPLICATION_JSON` &mdash; Application JSON File *ApplicationFile*. Path to the application configuration JSON [notes](#application_json)
- `APPLICATION_JSON_PREFIX` &mdash; Application JSON Prefix *String*. Prefix to place we can store things in the JSON [notes](#application_json_prefix)
- `APPLICATION_NAME` &mdash; Application Name *String*. This is the display name of the application [notes](#application_name)
- `APPLICATION_OWNER` &mdash; Application Legal Owner *String*. The entity which owns or manages the application. Typically the [notes](#application_owner)
- `BUILD_COMPANY` &mdash; Company Name *String*. Legal copyright holder for this codebase [notes](#build_company)
- `BUILD_COMPANY_LINK` &mdash; Company URL *URL*. Legal copyright holder website for this codebase [notes](#build_company_link)
- `BUILD_HOOK_EXTENSIONS` &mdash; Build Hook Extension List *ColonDelimitedList*. List of extensions to run when looking for hooks [notes](#build_hook_extensions)
- `BUILD_MAINTENANCE_CREATED_FILE` &mdash; Maintenance Created Flag *Boolean*. When true, means the `.env.local` file was created by the [notes](#build_maintenance_created_file)
- `BUILD_MAINTENANCE_MESSAGE_VARIABLE` &mdash; Maintenance Variable Message Name *EnvironmentVariable*. Name of the environment variable (if any) which reflects the [notes](#build_maintenance_message_variable)
- `BUILD_MAINTENANCE_VARIABLE` &mdash; Maintenance Variable Name *EnvironmentVariable*. The maintenance variable name which enables (or disabled) maintenance mode. [notes](#build_maintenance_variable)
- `BUILD_PROJECT_DEACTIVATE` &mdash; Project Deactivation Function *Function*. Set this to a function which cleans up the project [notes](#build_project_deactivate)
- `BUILD_TERM_COLORS_STATE` &mdash; Terminal Color State *String*. State to store state of current terminal color state [notes](#build_term_colors_state)

## Bash

- `BUILD_DOCUMENTATION_PATH` &mdash; Build Documentation Path List *DirectoryList*. Search path for documentation settings file. [notes](#build_documentation_path)
- `DISPLAY` &mdash; X Display *String*. Environment variable for X windows display. [notes](#display)
- `EDITOR` &mdash; Editor Command *Callable*. Binary for editing files [notes](#editor)
- `HOME` &mdash; User Home *Directory*. Current user's home directory. [notes](#home)
- `LC_TERMINAL` &mdash; Terminal Application *String*. LC_TERMINAL typically identifies the terminal application [notes](#lc_terminal)
- `MANPATH` &mdash; Manual Pages Path *DirectoryList*. A colon `:` separated list of paths to search for [notes](#manpath)
- `PATH` &mdash; Executable Search Path *DirectoryList*. A colon `:` separated list of paths to search for [notes](#path)
- `PRODUCTION` &mdash; Production Flag *Boolean*. Is this a production system? e.g. remove unnecessary runtime checks. [notes](#production)
- `PROMPT_COMMAND` &mdash; Prompt function *Callable*. Command is run before displaying the prompt, receives exit status [notes](#prompt_command)
- `PS1` &mdash; Bash Command Prompt *String*. Bash Prompt for terminals [notes](#ps1)
- `SHFMT_ARGUMENTS` &mdash; Shell Formatting Arguments *Array*. Arguments passed to shfmt when running as a pre-commit hook [notes](#shfmt_arguments)
- `TERM` &mdash; Terminal Type *String*. The current terminal type. [notes](#term)
- `VISUAL` &mdash; File Preview *Executable*. Binary for viewing files [notes](#visual)

## Bash Prompt

- `__BASH_PROMPT_MARKERS` &mdash; Prompt marker list *Array:EmptyString*. Bash Prompt escape codes for prompt reporting [notes](#__bash_prompt_markers)
- `__BASH_PROMPT_MODULES` &mdash; Prompt module list *Array:Callable*. List of functions to run each prompt command [notes](#__bash_prompt_modules)
- `__BASH_PROMPT_PREVIOUS` &mdash; Prompt command previous result *Array*. Previous result code [notes](#__bash_prompt_previous)
- `__BASH_PROMPT_SLOW` &mdash; Prompt command slow threshold *PositiveInteger*. Bash Prompt slow timer [notes](#__bash_prompt_slow)

## Build Configuration

- `BUILD_CACHE_HOME` &mdash; Build Cache Directory *Directory*. Location for the build system cache files. Defaults to `$HOME/.build` [notes](#build_cache_home)
- `BUILD_DEBUG` &mdash; Debugging Flag *CommaDelimitedList*. Constant for turning debugging on during build to find errors [notes](#build_debug)
- `BUILD_DEBUG_LINES` &mdash; Debugging output lines *PositiveInteger*. Number of lines of debugging output to send to stderr [notes](#build_debug_lines)
- `BUILD_ENVIRONMENT_DIRS` &mdash; Build Environment Directory List *DirectoryList*. Search directory for environment definition files. `:` separated. [notes](#build_environment_dirs)
- `BUILD_HOME` &mdash; Build Home Directory *Directory*. `BUILD_HOME` is `.` when this code is installed - at [notes](#build_home)
- `BUILD_HOOK_DIRS` &mdash; Build Hook Directory List *ApplicationDirectoryList*. List of directories to search for hooks. Defaults to `bin/hooks:bin/build/hooks`. [notes](#build_hook_dirs)
- `BUILD_INSTALL_URL` &mdash; Build Installation URL *URL*. `BUILD_INSTALL_URL` for `installInstallBuild` - source URL for a raw installer. [notes](#build_install_url)
- `BUILD_MAXIMUM_TAGS_PER_VERSION` &mdash; Maximum Git Tags per Version *PositiveInteger*. Number of versions tags (d0, d1, d2, etc.) to look [notes](#build_maximum_tags_per_version)
- `BUILD_NOTIFY_SOUND` &mdash; Notification Sound *String*. Sound for notifications. Set to `-` for no sound. Defaults [notes](#build_notify_sound)
- `BUILD_PRECOMMIT_EXTENSIONS` &mdash; Pre-Commit Extension List *List*. List of extensions for which build hooks may be written [notes](#build_precommit_extensions)
- `BUILD_RELEASE_NOTES` &mdash; Release Notes Application Path *ApplicationDirectory*. Constant for the release notes path. Defaults to `./docs/release`. [notes](#build_release_notes)
- `BUILD_URL_TIMEOUT` &mdash; URL Timeout *PositiveInteger*. Timeout in seconds for fetching URLs in `urlFetch` [notes](#build_url_timeout)
- `BUILD_VERSION_NO_OPEN` &mdash; Build Version No Open Flag *Boolean*. Constant for whether to open release notes when a version [notes](#build_version_no_open)
- `BUILD_VERSION_SUFFIX` &mdash; Build Version Suffix *String*. Default suffix used in `gitTagVersion` [notes](#build_version_suffix)
- `IP_URL` &mdash; IP Lookup URL *URL*. URL to look up IP my address remotely [notes](#ip_url)
- `IP_URL_FILTER` &mdash; Filter for IP Lookup *String*. jq filter to parse IP_URL result (assuming JSON) [notes](#ip_url_filter)
- `XDG_CACHE_HOME` &mdash; Main Cache Directory *Directory*. Main Cache Directory [notes](#xdg_cache_home)
- `XDG_CONFIG_DIRS` &mdash; Configuration Path Directories *DirectoryList*. Configuration Path Directories [notes](#xdg_config_dirs)
- `XDG_CONFIG_HOME` &mdash; Main Configuration Path *Directory*. Main Configuration Path [notes](#xdg_config_home)
- `XDG_DATA_DIRS` &mdash; Data Path Directories *DirectoryList*. Data Path Directories [notes](#xdg_data_dirs)
- `XDG_DATA_HOME` &mdash; Data Home Directory *Directory*. Data Home Directory [notes](#xdg_data_home)
- `XDG_STATE_HOME` &mdash; State Home Directory *Directory*. State Home Directory [notes](#xdg_state_home)

## Continuous Integration

- `BITBUCKET_CLONE_DIR` &mdash; Bitbucket Clone Directory *Directory*. Defined in BITBUCKET Pipelines [notes](#bitbucket_clone_dir)
- `BITBUCKET_REPO_SLUG` &mdash; Bitbucket Repository Slug *String*. Defined in BITBUCKET Pipelines, represents the project code name. [notes](#bitbucket_repo_slug)
- `BITBUCKET_WORKSPACE` &mdash; Bitbucket Workspace *String*. Defined in BITBUCKET Pipelines. represents the project workspace. [notes](#bitbucket_workspace)
- `CI` &mdash; Continuous Integration *String*. If this value is non-blank, then console `statusMessage`s are just [notes](#ci)

## Continuous Integration: BitBucket

- `BUILD_DOCKER_BITBUCKET_IMAGE` &mdash; Docker Image for Bitbucket Containers *String*. undocumented 
- `BUILD_DOCKER_BITBUCKET_PATH` &mdash; Docker Path for Bitbucket Containers *RemoteDirectory*. undocumented 

## Decoration

- `BUILD_COLORS` &mdash; Build Colors Flag *Boolean*. If true then colors are shown, blank means guess the [notes](#build_colors)
- `BUILD_PAIR_WIDTH` &mdash; Pair Width *PositiveInteger*. Width for pairs. Defaults to `40`. [notes](#build_pair_width)
- `BUILD_PROMPT_COLORS` &mdash; Prompt Color List *ColonDelimitedList*. Colon-separated list of colors for the prompt [notes](#build_prompt_colors)
- `BUILD_TEXT_BINARY` &mdash; Text Executable *Callable*. Binary used to generate `decorate big` [notes](#build_text_binary)
- `BUILD_URL_BINARY` &mdash; URL Executable *Callable*. Binary used in __urlOpen [notes](#build_url_binary)
- `COLORFGBG` &mdash; Terminal Foreground and Background *String*. Standard way to express the foreground and background colors [notes](#colorfgbg)

## Deployment

- `APPLICATION_BUILD_DATE` &mdash; Application Build Date *String*. Time when a build was initiated, set upon first invocation [notes](#application_build_date)
- `APPLICATION_ID` &mdash; Application ID *String*. This is the unique hash which represents the source code [notes](#application_id)
- `APPLICATION_REMOTE_HOME` &mdash; Application Remote Home Directory *RemoteDirectory*. Path on the remote server where the application is served [notes](#application_remote_home)
- `APPLICATION_TAG` &mdash; Application Tag *String*. This is the full version number including debugging or release [notes](#application_tag)
- `APPLICATION_VERSION` &mdash; Application Version *String*. This is the version number which can be displayed [notes](#application_version)
- `BUILD_TARGET` &mdash; Build Application Target File Name *String*. The file to generate when generating builds [notes](#build_target)
- `BUILD_TIMESTAMP` &mdash; Build Timestamp *UnsignedInteger*. Time when a build was initiated, set upon first invocation [notes](#build_timestamp)
- `DEPLOY_REMOTE_HOME` &mdash; Remote directory for deployment *RemoteDirectory*. Path on the remote server where the application deployment home [notes](#deploy_remote_home)
- `DEPLOY_USER_HOSTS` &mdash; Host list for deployment *String*. A list of one ore more user@host for installation of [notes](#deploy_user_hosts)
- `DEPLOYMENT` &mdash; Deployment Code *String*. Target deployment for this code [notes](#deployment)

## Deployment: GitHub

- `GITHUB_REPOSITORY_OWNER` &mdash; GitHub Repository Owner *String*. Repository owner for release [notes](#github_repository_owner)

## Development

- `BUILD_DEVELOPMENT_HOME` &mdash; Home for Zesk Build development *String*. Directory where Zesk Build is being developed in the file [notes](#build_development_home)
- `GIT_BRANCH_FORMAT` &mdash; Git Branch Format String *String*. undocumented 
- `GIT_OPEN_LINKS` &mdash; Git Open Links Flag *Boolean*. Open links from git remotes in `gitCommit` [notes](#git_open_links)
- `GIT_REMOTE` &mdash; GitHub Remote Name *String*. undocumented 
- `GITHUB_ACCESS_TOKEN` &mdash; GitHub Access Token *Secret*. Access token used for release [notes](#github_access_token)
- `GITHUB_ACCESS_TOKEN_EXPIRE` &mdash; GitHub Access Token Expiration Date *Date*. GitHub Access token expiration date. Invalid AFTER this date. [notes](#github_access_token_expire)
- `GITHUB_REPOSITORY_NAME` &mdash; GitHub Repository Name *String*. Repository name for release [notes](#github_repository_name)

## Docker

- `BUILD_DOCKER_IMAGE` &mdash; Docker Image *String*. Default docker image to use when launching `dockerLocalContainer` [notes](#build_docker_image)
- `BUILD_DOCKER_PATH` &mdash; Docker Mapped Path *RemoteDirectory*. Default path for the shell to map the current directory [notes](#build_docker_path)
- `BUILD_DOCKER_PLATFORM` &mdash; Docker Platform *String*. The platform for `dockerLocalContainer` [notes](#build_docker_platform)

## Documentation

- `BUILD_DOCUMENTATION_SOURCE_LINK_PATTERN` &mdash; Build documentation URL Pattern *String*. Links in documentation [notes](#build_documentation_source_link_pattern)

## Installation

- `BUILD_COMPOSER_VERSION` &mdash; Composer Version *String*. Version of composer to use for building vendor directory [notes](#build_composer_version)
- `BUILD_NPM_VERSION` &mdash; npm Version *String*. Version of npm to install using native `npm` binary. [notes](#build_npm_version)
- `BUILD_PACKAGE_MANAGER` &mdash; Package Manager Binary *Executable*. The default package manager on systems which have more than [notes](#build_package_manager)

## Internal

- `__BUILD_HAS_TTY` &mdash; TTY Cached Result *Boolean*. Cached value of the availability of `/dev/tty`. [notes](#__build_has_tty)

## Notify

- `NOTIFY_URL` &mdash; Notification URL *URL*. URL to send default notifications [notes](#notify_url)
- `NOTIFY_URL_AUTHORIZATION` &mdash; Notification URL Authorization Token *Secret*. Authorization token for default notifications. [notes](#notify_url_authorization)

## PHP

- `XDEBUG_ENABLED` &mdash; xDebug Enabled Flag *Boolean*. Is xdebug enabled? The application can honor this environment variable [notes](#xdebug_enabled)

## Testing

- `BUILD_TEST_FLAGS` &mdash; Test Flags *String*. Test flags affect controls and how tests are run. [notes](#build_test_flags)
- `TEST_TRACK_ASSERTIONS` &mdash; Track Assertions Flag *Boolean*. Assertion tracking testing optimization [notes](#test_track_assertions)

## Vendor

- `APACHE_HOME` &mdash; Apache Home Directory *Directory*. Constant for the Apache configuration home directory. [notes](#apache_home)
- `BUILD_YARN_VERSION` &mdash; Yarn Version *String*. Version of yarn to install using `corepack` [notes](#build_yarn_version)
- `DAEMONTOOLS_HOME` &mdash; Daemontools Home *Directory*. Constant for the directory where services are monitored by daemontools [notes](#daemontools_home)
- `MARIADB_BINARY_CONNECT` &mdash; mariadb Connect Executable *Executable*. MariaDB binary for database connections [notes](#mariadb_binary_connect)
- `MARIADB_BINARY_DUMP` &mdash; mariadb Dump Executable *Executable*. MariaDB binary for dump [notes](#mariadb_binary_dump)
- `NODE_PACKAGE_MANAGER` &mdash; node Package Manager *Executable*. The package manager used for node operations. Usually `yarn` or [notes](#node_package_manager)

