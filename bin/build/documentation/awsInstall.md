### `awsInstall`

> aws Command-Line install

#### Usage

    awsInstall

aws Command-Line install

Installs x86 or aarch64 binary based on `HOSTTYPE`.

> Location: `bin/build/tools/aws.sh`

#### Arguments

- none

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [packageInstall]({rel}tools/package.md#packageinstall) - Install packages using a package manager ([source](https://github.com/zesk/build/blob/main/bin/build/tools/package.sh#L377))
- [urlFetch]({rel}tools/url.md#urlfetch) - Fetch URL content ([source](https://github.com/zesk/build/blob/main/bin/build/tools/url.sh#L566))

