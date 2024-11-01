# apt Package Manager Tools

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `aptIsInstalled` - Is apt-get installed?

Is apt-get installed?

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

## Apt Key Management

### `aptSourcesDirectory` - Get APT source list path

Get APT source list path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `aptKeyAdd` - Add keys to enable apt to download terraform directly from

Add keys to enable apt to download terraform directly from hashicorp.com

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `--title title` - Optional. String. Title of the key.
- `--name name` - Required. String. Name of the key used to generate file names.
- `--url remoteUrl` - Required. URL. Remote URL of gpg key.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptKeyRemove` - Remove apt keys

Remove apt keys

- Location: `bin/build/tools/apt.sh`

#### Arguments

- `keyName` - Required. String. One or more key names to remove.

#### Exit codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK
### `aptKeyRingDirectory` - Get key ring directory path

Get key ring directory path

- Location: `bin/build/tools/apt.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
