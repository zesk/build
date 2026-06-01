## `bashDocumentationDefaults`

> Generate base template files for Bash code documentation.

### Usage

    bashDocumentationDefaults --target templateTarget [ --help ] [ --handler handler ]

Generates the following (with example content):
- `applicationName.md` - `Zesk Build`
- `applicationOwner.md` - `Market Acumen, Inc.`
- `year.md` - `2026`
- `version.md` - `v0.43.2`
- `timestamp.md` - `1779910142`
- `timestampString.md` - `2026-05-27 15:29:15`

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--target templateTarget` - FileDirectory. Required. Create templates here.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

