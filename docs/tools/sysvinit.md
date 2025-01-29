# System V Initialization

For systems with an `/etc/init.d` start up script system.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `sysvInitScriptInstall` - Install a script to run upon initialization.

Install a script to run upon initialization.

- Location: `bin/build/tools/sysvinit.sh`

#### Usage

_mapEnvironment

#### Arguments

- `binary` - Required. String. Binary to install at startup.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `sysvInitScriptUninstall` - Remove an initialization script

Remove an initialization script

- Location: `bin/build/tools/sysvinit.sh`

#### Usage

_mapEnvironment

#### Arguments

- `binary` - Required. String. Basename of installed

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
