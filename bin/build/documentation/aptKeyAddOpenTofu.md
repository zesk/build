### `aptKeyAddOpenTofu`

> Add keys to enable apt to download tofu directly from

#### Usage

    aptKeyAddOpenTofu [ --help ]

Add keys to enable apt to download tofu directly from opentofu.org

> Location: `bin/build/tools/tofu.sh`

#### Arguments

- `--help` - Flag. Optional. Display this help.

#### Return codes

- `1` - if environment is awry
- `0` - All good to install terraform

#### See Also

- [aptKeyRemoveOpenTofu]({rel}tools/tofu.md#aptkeyremoveopentofu) - Remove keys to disable apt to download tofu from opentofu.org ([source](https://github.com/zesk/build/blob/main/bin/build/tools/tofu.sh#L43))

