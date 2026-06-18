### `documentationEnvironmentMake`

> Build documentation files for environment variables

#### Usage

    documentationEnvironmentMake [ --source sourcePath ] [ --template templatePath ] [ --target targetPath ] [ --clean ] [ --force ] [ --verbose ] [ --link linkURI ] [ --help ]

Build documentation for `./bin/env` (or `bin/build/env`) directory.

Creates a cache at `documentationCache`

Environment template files used:

- `line.md`
- `see.md`
- `more.md`
- `more-header.md`
- `more-footer.md`

Variables applied to the environment template files:

- `link` `name` `description` `category` `more` `type` `markerName`

Documentation Files generated:

- `ENV_NAME.md` - Documentation page for `ENV_NAME`
- `SEE/ENV_NAME.md` - `{"SEE:ENV_NAME"}` content
- `env/ENV_NAME.sh` - Settings extracted from environment file.
- `env/ENV_NAME.md` - Documentation line for `ENV_NAME`
- `env/more/ENV_NAME.md` - Documentation more for `ENV_NAME`. Only created if needed.

Documentation settings extracted:

- `name` - `String`. Display environment name.
- `description` - `String`. Text description of the environment variable, many lines long and can include detailed example and markup.
- `descriptionLineCount` - `PositiveInteger`. Number of lines in the description.
- `summary` - `String`. Short description of the environment variable.
- `category` - `String`. Main category for this environment variable.
- `categoryId` - `String`. Category converted to stringLowercase and spaces replaced with underscores.
- `type` - `Type`. Data type for this environment variable.

Where `ENV_NAME` matches the found environment source file without the `.sh`.

Target templates created:

- `categories.txt`
- `environmentCategoryList.md`
- `environmentCategoryTotal.md`
- `environmentMore.md`

> Location: `bin/build/tools/documentation.sh`

#### Arguments

- `--source sourcePath` - Directory. Optional. Path to source environment files (`*.sh` files). Defaults to `$(buildHome)/bin/env` if not specified.
- `--template templatePath` - Directory. Optional. Path for environment template files.
- `--target targetPath` - Directory. Optional. Path for generated documentation files.
- `--clean` - Flag. Optional. Delete any generated files amd exit.
- `--force` - Flag. Optional. Force generation of files regardless of cache status.
- `--verbose` - Flag. Optional. Be chatty.
- `--link linkURI` - String. Optional. Sets the `link` variable in templates. Defaults to `/env/`.
- `--help` - Flag. Optional. Display this help.

#### Return codes

- `0` - Success
- `1` - Issue with environment
- `2` - Argument error

#### Environment

- [`BUILD_DOCUMENTATION_PATH` Build Documentation Path List]({rel}env/#bash) – **DirectoryList**. Search path for documentation settings file.

