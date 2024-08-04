# Hooks

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />


### `application-tag.sh` - Get the "tag" (or current display version) for an application

Get the "tag" (or current display version) for an application

The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.

#### Exit codes

- `0` - Always succeeds

### `version-already.sh` - Run whenever `new-version.sh` is run and a version already exists

Run whenever `new-version.sh` is run and a version already exists

Opens the release notes in the current editor.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook

### `version-created.sh` - Run whenever `new-version.sh` is run and a version was just

Run whenever `new-version.sh` is run and a version was just created.

Opens the release notes in the current editor.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_NO_OPEN - Do not open in the default editor. Set this is you do not want the behavior and do not have an override `version-created` hook

### `version-current.sh` - Hook to return the current version

Hook to return the current version

Defaults to the last version numerically found in `docs/release` directory.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_CREATED_EDITOR - Define editor to use to edit release notes
EDITOR - Default if `BUILD_VERSION_CREATED_EDITOR` is not defined
