# Zesk Build Encodings

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

A place to store and organize the various encodings used throughout this project.

## Comma `,`

- Decorate style in extension arguments uses `,` separated lists

## Colon `:`

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
- `BUILD_TEST_FLAGS` uses `:` for name/value pairs in a list separated by `;`, so:
  `Assert-Statistics:true;Plumber:false` as an example

## Semicolon `:`

- `BUILD_TEST_FLAGS` uses `:` for name/value pairs in a list separated by `;`, so:
  `Assert-Statistics:true;Plumber:false` as an example
- ANSI console codes are `;`-separated color values
- Decoration style names use a `:` separated list and `=` to delimit values

## Space ... the final frontier

- `BUILD_PRECOMMIT_EXTENSIONS` uses ` ` to delimit extensions
- `DEPLOY_USER_HOSTS` uses ` ` to delimit remote host names

## Arrays

These are initialized as Bash arrays and can be expressed as `${variable[@]}` in code.

- `SHFMT_ARGUMENTS` is a bash array

If in doubt do:

    export VAR_WHICH_SHOULD_BE_AN_ARRAY
    isArray VAR_WHICH_SHOULD_BE_AN_ARRAY || VAR_WHICH_SHOULD_BE_AN_ARRAY=()
    myProgram "${VAR_WHICH_SHOULD_BE_AN_ARRAY[@]}" "$workItem"

## Brackets `{}`

- `mapEnvironment` defaults to using tokens with `{brackets}`
- `mapValue` defaults to using tokens with `{brackets}`

## UFOs `[()]`

- Decoration themed functionality uses `[(name)]` tokens in text which are universally replaced

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
