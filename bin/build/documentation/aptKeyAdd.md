## `aptKeyAdd`

> Add keys to enable apt to download terraform directly from

### Usage

    aptKeyAdd [ --title keyTitle ] --name keyName --url remoteUrl [ --help ]

Add keys to enable apt to download terraform directly from hashicorp.com

### Arguments

- `--title keyTitle` - String. Optional. Title of the key.
- `--name keyName` - String. Required. Name of the key used to generate file names.
- `--url remoteUrl` - URL. Required. Remote URL of gpg key.
- `--help` - Flag. Optional. Display this help.

### Return codes

- `1` - if environment is awry
- `0` - Apt key is installed AOK

