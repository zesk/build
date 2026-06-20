### `documentationMkdocs`

> mkdocs Utility

#### Usage

    documentationMkdocs [ --path documentationPath ] [ --template yamlTemplate ] [ --package packageName ] [ --version version ] [ --clean ] [ --help ]

Build documentation using `mkdocs` and a template.

> Location: `bin/build/tools/mkdocs.sh`

#### Arguments

- `--path documentationPath` - Directory. Optional. Directory where documentation root exists.
- `--template yamlTemplate` - File. Optional. Name of `mkdocs.yml` template file to generate final file. Default is `mkdocs.template.yml`.
- `--package packageName` - String. Optional. Install this python package when setting up `mkdocs`.
- `--version version` - String. Optional. Use this for current version of documentation; defaults to `hookVersionCurrent`
- `--clean` - Flag. Optional. Clean the python virtual environment first.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### See Also

- [hookVersionCurrent]({rel}tools/hooks.md#hookversioncurrent) - Application current version ([source](https://github.com/zesk/build/blob/main/bin/build/tools/hooks.sh#L93))

