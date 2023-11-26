# Version hooks

[⬅ Return to hook index](index.md)

These hooks interact with `new-release.sh` and deployment tools but are intended to be used anywhere.

- `version-current` - Required. The current version. Defaults to greatest version in `docs/release`.
- `version-live` - Optional. Determine the live version.
- `version-created` - Optional. Run when a new version is created.
- `version-already` - Optional. Run when a new version is requested but it already exists in the source code.

# Version Status Hooks

{hookVersionCurrent}
{hookVersionLive}

# `new-release.sh` Hooks

{hookVersionAlready}
{hookVersionCreated}

[⬅ Return to hook index](index.md)
