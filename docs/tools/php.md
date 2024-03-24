# PHP Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `phpInstall` - Install `php`

Install `php`

If this fails it will output the installation log.

When this tool succeeds the `python` binary is available in the local operating system.

#### Usage

    phpInstall [ package ... ]
    

#### Arguments



#### Exit codes

- `1` - If installation fails
- `0` - If installation succeeds

### `composer.sh` - Run Composer commands on code

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.

This tools does not install the `composer` binary into the local environment.





#### Usage

    composer.sh [ --help ] [ installDirectory ]
    

#### Arguments



#### Examples

    bin/build/pipeline/composer.sh ./app/

#### Exit codes

- `0` - Always succeeds

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

- [Source BUILD_TARGET.sh
](https://github.com/zesk/build/blob/main/bin/build/env/BUILD_TARGET.sh#L{line}
)

### `phpLog` - Outputs the path to the PHP log file

Outputs the path to the PHP log file

#### Usage

    phpLog
    

#### Exit codes

- `0` - Always succeeds

### `php.sh` - Test a docker-based PHP application during build

Test a docker-based PHP application during build

#### Usage

    php.sh deployment
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
