# Zesk Build Encodings

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

A place to store and organize the various encodings used throughout this project.

## Decorate

- Decoration style names use a `:` separated list and `=` to delimit values
- ANSI console codes are `;`-separated color values
- Decoration themed functionality uses `[(name)]` tokens in text which are universally replaced
- Decorate style in extension arguments uses `,` separated lists

## Environment

- `APPLICATION_CODE_EXTENSIONS` uses `:` to delimit arguments
- `APPLICATION_CODE_IGNORE` uses `:` to delimit arguments
- `APPLICATION_JSON_PREFIX` uses `.` to delimit path segments
- `BUILD_ENVIRONMENT_DIRS` uses `:` to delimit paths
- `BUILD_HOOK_DIRS` uses `:` to delimit paths
- `BUILD_HOOK_EXTENSIONS` uses `:` to delimit extensions
- `PATH` uses `:` to delimit arguments
- `MANPATH` uses `:` to delimit arguments
- `BUILD_PROMPT_COLORS` uses `:` to delimit colors (5 total)
- `XDG_CONFIG_DIRS` uses `:` to delimit paths
- `XDG_DATA_DIRS` uses `:` to delimit paths

## Space ... the final frontier

- `BUILD_PRECOMMIT_EXTENSIONS` uses ` ` to delimit extensions
- `DEPLOY_USER_HOSTS` uses ` ` to delimit remote host names

## Arrays

- `SHFMT_ARGUMENTS` is a bash array

## Brackets

- `mapEnvironment` defaults to using tokens with `{brackets}`
- `mapValue` defaults to using tokens with `{brackets}`
