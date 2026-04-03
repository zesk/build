## `decoratePath`

> Display file paths and replace prefixes with icons

### Usage

    decoratePath [ --help ] [ --path pathName=icon ] [ --no-app ] [ --skip-app ] [ path ]

Replace an absolute path prefix with an icon if it matches `HOME`, `BUILD_HOME` or `TMPDIR`
Icons used:
- 💣 - `TMPDIR`
- 🍎 - `BUILD_HOME`
- 🏠 - `HOME`

### Arguments

- `--help` - Flag. Optional. Display this help.
--path pathName=- `icon` - Flag. Optional. Add an additional path mapping to icon.
- `--no-app` - Flag. Optional. Do not map `BUILD_HOME`.
- `--skip-app` - Flag. Optional. Synonym for `--no-app`.
- `path` - String. Path to display and replace matching paths with icons.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- TMPDIR
- {SEE:BUILD_HOME.sh}
- {SEE:HOME.sh}

