### `environmentVariables`

> Output a list of environment variables and ignore function definitions

#### Usage

    environmentVariables

Output a list of environment variables and ignore function definitions

both `set` and `env` output functions and this is an easy way to just output
exported variables

> Location: `bin/build/tools/environment.sh`

#### Arguments

- none

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`declare`]({rel}guide/builtin.md#declare)
- [`grep`]({rel}guide/command.md#grep)
- [`cut`]({rel}guide/command.md#cut)
- [bashDocumentation]({rel}tools/documentation.md#bashdocumentation) - Universal function documentation ([source](https://github.com/zesk/build/blob/main/bin/build/tools/usage.sh#L59))
- [helpArgument]({rel}tools/argument.md#helpargument) - Simple help argument handler. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/argument.sh#L576))

