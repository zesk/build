
# `git-tag-version.sh` - Tag a version of the software in git and push

[⬅ Return to top](index.md)

Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.

## Usage

    git-tag-version.sh [ --suffix versionSuffix ] Tag version in git

## Exit codes

- `0` - Always succeeds

## Environment

BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
