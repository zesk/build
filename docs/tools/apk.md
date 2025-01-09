# Alpine Package Manager Tools

`apk-tools`

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `apkIsInstalled` - Is this an Alpine system and is apk installed?

Is this an Alpine system and is apk installed?

- Location: `bin/build/tools/apk.sh`

#### Arguments

- `--help` - Optional. Flag. Display this help.

#### Exit codes

- `0` - System is an alpine system and apk is installed
- `1` - System is not an alpine system or apk is not installed
### `alpineContainer` - Open an Alpine container shell

Open an Alpine container shell

- Location: `bin/build/tools/apk.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
