# Version Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `releaseNotes` - Output path to current release notes

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file



#### Usage

    releaseNotes [ version ]
    

#### Arguments



#### Examples

    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

#### Exit codes

- `1` - if an error occurs

#### Environment

BUILD_RELEASE_NOTES

### `newRelease` - Generate a new release notes and bump the version

**New release** - generates files in system for a new release.

*Requires* hook `version-current`, optionally `version-live`

Uses semantic versioning `MAJOR.MINOR.PATCH`

Checks the live version versus the version in code and prompts to
generate a new release file if needed.

A release notes template file is added at `./docs/release/`. This file is
also added to `git` the first time.

#### Arguments



#### Exit codes

- `0` - Release generated or has already been generated
- `1` - If new version needs to be created and `--non-interactive`

### `nextMinorVersion` - Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

#### Usage

    nextMinorVersion lastVersion
    

#### Exit codes

- `0` - Always succeeds
