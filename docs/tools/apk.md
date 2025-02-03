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
### `isAlpine` - Is this an Alpine system?

Is this an Alpine system?

- Location: `bin/build/tools/apk.sh`

[42;30m[1;91m[0m

[92mUsage[0m: [38;5;20misMappable[0m [94m[ --prefix ][0m [94m[ --suffix ][0m [94m[ --token ][0m [94m[ text ][0m

    [94m--prefix  [1;40;97mOptional. String. Token prefix defaults to [1;97;44m{[0m.[0m
    [94m--suffix  [1;40;97mOptional. String. Token suffix defaults to [1;97;44m}[0m.[0m
    [94m--token   [1;40;97mOptional. String. Classes permitted in a token[0m
    [94mtext      [1;40;97mOptional. String. Text to search for mapping tokens.[0m

Check if text contains mappable tokens
If any text passed contains a token which can be mapped, succeed.
#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
