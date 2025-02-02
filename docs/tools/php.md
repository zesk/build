# PHP Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is available in the local operating system.

- Location: `bin/build/tools/php.sh`

#### Arguments

- `package` - Additional packages to install

#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds
### `composer.sh` - Run Composer commands on code

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.

This tools does not install the `composer` binary into the local environment.





- Location: `bin/build/tools/php.sh`

#### Arguments

- `installDirectory` - You can pass a single argument which is the directory in your source tree to run composer. It should contain a `composer.json` file.
- `--help` - This help

#### Examples

    phpComposer ./app/

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Local cache

This tool uses the local `.composer` directory to cache information between builds. If you cache data between builds for speed, cache the `.composer` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.

#### Environment

BUILD_COMPOSER_VERSION - String. Default to `latest`. Used to run `docker run composer/$BUILD_COMPOSER_VERSION` on your code
### `phpBuild` - Build deployment using composer, adding environment values to .env and

Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into target file, usually `BUILD_TARGET`

Override target file generated with environment variable `BUILD_TARGET` which must ae set during build
and on remote systems during deployment.

Files are specified from the application root directory.

`phpBuild` generates the `.build.env` file, which contains the current environment and:

- BUILD_TARGET
- BUILD_START_TIMESTAMP
- APPLICATION_TAG
- APPLICATION_ID

- Location: `bin/build/tools/php.sh`

#### Arguments

--skip-tag |- ` --no-tag` - Optional. Flag. Do not tag the release.
- `--name tarFileName` - String. Optional. Set BUILD_TARGET via command line (wins)
- `--composer arg` - Optional. Argument. Supply one or more arguments to `phpComposer` command. (Use multiple times)
- `--help` - Optional. Flag. Display this help.
- `ENV_VAR1` - Optional. Environment variables to build into the deployed .env file
- `--` - Required. Separates environment variables to file list
- `file1 file2 dir3 ...` - Required. List of files and directories to build into the application package.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [{fn}]({sourceLink})
### `phpLog` - Outputs the path to the PHP log file

Outputs the path to the PHP log file

- Location: `bin/build/tools/php.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `phpTest` - Test a docker-based PHP application during build

Test a docker-based PHP application during build

- Location: `bin/build/tools/php.sh`

#### Arguments

- `--env-file envFile` - Optional. File. Environment file to load.
- `--home homeDirectory` - Optional. Directory. Directory for application home.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `phpIniFile` - Outputs the path to the PHP ini file

Outputs the path to the PHP ini file

- Location: `bin/build/tools/php.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `phpTailLog` - Tail the PHP log

Tail the PHP log

- Location: `bin/build/tools/php.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
