# Version Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `releaseNotes` - Output path to current release notes

Output path to current release notes

If this fails it outputs an error to stderr

When this tool succeeds it outputs the path to the current release notes file


- Location: `bin/build/tools/version.sh`

#### Usage

_mapEnvironment

#### Arguments

- `version` - Optional. String. Version for the release notes path. If not specified uses the current version.

#### Examples

    open $(bin/build/release-notes.sh)
    vim $(releaseNotes)

#### Sample Output

    docs/release/version.md
    

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

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

- Location: `bin/build/tools/version.sh`

#### Usage

_mapEnvironment

#### Arguments

- `--non-interactive` - Optional. If new version is needed, use default version
- `versionName - Optional. Set the new version name to this` - must be after live version in version order

#### Exit codes

- `0` - Release generated or has already been generated
- `1` - If new version needs to be created and `--non-interactive`
### `nextMinorVersion` - Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

Converts vX.Y.N to vX.Y.(N+1) so v1.0.0 to v1.0.1

- Location: `bin/build/tools/version.sh`

#### Usage

_mapEnvironment

#### Arguments

- `lastVersion` - Required. String. Version to calculate the next minor version.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isVersion` - Check if something matches a version

Check if something matches a version

- Location: `bin/build/tools/version.sh`

#### Usage

_mapEnvironment

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
