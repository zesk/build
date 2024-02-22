# Version hooks

[⬅ Return to hook index](index.md)

These hooks interact with `new-release.sh` and deployment tools but are intended to be used anywhere.

- `version-current` - Required. The current version. Defaults to greatest version in `docs/release`.
- `version-live` - Optional. Determine the live version.
- `version-created` - Optional. Run when a new version is created.
- `version-already` - Optional. Run when a new version is requested but it already exists in the source code.

# Version Status Hooks


### `version-current.sh` - Hook to return the current version

Hook to return the current version

Defaults to the last version numerically found in `docs/release` directory.

#### Exit codes

- `0` - Always succeeds

#### Environment

BUILD_VERSION_CREATED_EDITOR - Define editor to use to edit release notes
EDITOR - Default if `BUILD_VERSION_CREATED_EDITOR` is not defined

### `version-live.sh` - Live version of the application

Output the current live, published version of this application.

If implemented, `new-release.sh` will create a release only when needed.

#### Exit codes

- `0` - Always succeeds

#### See Also

- [Source github-version-live.sh
](https://github.com/zesk/build/blob/main/bin/build/pipeline/github-version-live.sh
#L{line}
)

# `new-release.sh` Hooks


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

[⬅ Return to hook index](index.md)
