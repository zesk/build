# `git-tag-version.sh` - Description

Tag a version of the software in git and push tags to origin.

If this fails it will output the installation log.

When this tool succeeds the git repository contains


## Usage

    git-tag-version.sh [ --suffix versionSuffix ] Tag version in git


## Arguments

- `--suffix` - word to use between version and index as: `Unable to find "current" (from "./docs/templates/pipeline/git-tag-version.sh.md") in "./bin/build/"rcUnable to find "nextIndex" (from "./docs/templates/pipeline/git-tag-version.sh.md") in "./bin/build/"`
## Hooks called

- `version-current`

## Local cache

No local caches.

## Environment which affects this tool

- `BUILD_VERSION_SUFFIX` - String. Version suffix to use as a default. If not specified the default is `rc`.

[⬅ Return to top](index.md)