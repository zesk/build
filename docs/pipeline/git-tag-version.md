
# `git-tag-version.sh` - Generates a git tag for a build version, so `v1.0d1`,

[⬅ Return to top](index.md)

Generates a git tag for a build version, so `v1.0d1`, `v1.0d2`, for version `v1.0`.
Tag a version of the software in git and push tags to origin.
If this fails it will output the installation log.
When this tool succeeds the git repository contains a tag with the suffix and an index which represents the build index.


- `d` - for **development**
- `s` - for **staging**
- `rc` - for **release candidate**

## Usage

    git-tag-version.sh [ --suffix versionSuffix ] Tag version in git

## Exit codes

- `0` - Always succeeds

## Environment

BUILD_VERSION_SUFFIX - String. Version suffix to use as a default. If not specified the default is `rc`.
BUILD_MAXIMUM_TAGS_PER_VERSION - Integer. Number of integers to attempt to look for when incrementing.
