# Application Hooks

[⬅ Return to hook index](index.md)


### `application-tag.sh` - Get the "tag" (or current display version) for an application

Get the "tag" (or current display version) for an application

The default hook uses most recent tag associated in git or `v0.0.1` if no tags exist.

#### Exit codes

- `0` - Always succeeds

### `application-checksum.sh` - Generate a unique checksum for the state of the application

Generate a unique checksum for the state of the application files

The default hook uses the short git checksum

#### Exit codes

- `0` - Always succeeds

