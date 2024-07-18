# PHP Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `php` binary is available in the local operating system.

#### Usage

    phpInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `/var/folders/6r/r9y5y7f51q592kr56jyz4gh80000z_/T/tmp.YlYM3IvjrO composer.sh` - Run Composer commands on code

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.

This tools does not install the `composer` binary into the local environment.

#### Exit codes

- `0` - Always succeeds

### `phpBuild` - Build deployment using composer, adding environment values to .env and

Build deployment using composer, adding environment values to .env and packaging vendor and additional
files into target file, usually `BUILD_TARGET`

Override target file generated with environment variable `BUILD_TARGET` which must ae set during build
and on remote systems during deployment.

Files are specified from the application root directory.

`phpBuild` generates the `.build.env` file, which contains the current environment and:

- DEPLOYMENT
- BUILD_TARGET
- BUILD_START_TIMESTAMP
- APPLICATION_TAG
- APPLICATION_ID

`DEPLOYMENT` is mapped to suffixes when `--suffix` not specified as follows:

- `rc` - production
- `d` - develop
- `s` - staging
- `t` - test

#### Usage

    phpBuild [ --name tarFileName ] [ --deployment deployment ] [ --suffix versionSuffix ] [ --debug ] [ ENV_VAR1 ... ] -- file1 [ file2 ... ]
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### See Also

{SEE:BUILD_TARGET.sh}

### `phpLog` - Outputs the path to the PHP log file

Outputs the path to the PHP log file

#### Usage

    phpLog
    

#### Exit codes

- `0` - Always succeeds

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
