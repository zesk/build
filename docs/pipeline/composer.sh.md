# `composer.sh` - Run Composer commands on code

Runs composer validate and install on a directory.

If this fails it will output the installation log.

When this tool succeeds the `composer` tool has run on a source tree and the `vendor` directory and `composer.lock` are often updated.

This tools does not install the `composer` binary into the local environment.

## Usage

    composer.sh [ --help ] [ installDirectory ]

## Arguments

You can pass a single argument which is the directory in your source tree to run composer. It should contain a `composer.json` file.

e.g.

    bin/build/pipeline/composer.sh ./app/

## Local cache

This tool uses the local `.composer` directory to cache information between builds. If you cache data between builds for speed, cache the `.composer` artifact if you use this tool. You do not need to do this but 2nd builds tend to be must faster with cached data.

## Environment which affects this tool

- `BUILD_COMPOSER_VERSION` - String. Default to `latest`. Used to run `docker run composer/$BUILD_COMPOSER_VERSION` on your code

[⬅ Return to top](index.md)