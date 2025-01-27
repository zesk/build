# bash Cheat Sheet

## Shell Options (`shopt`)

### Shell interactivity

- `cdable_vars` - Allows `cd HOME` (assumes any non-directory is the variable name) (Recommend `off`)
- `cdspell` - Description (Recommend `on`)

### Execution path

- `checkhash` - Description (Recommend `on`)

### Window size

- `checkwinsize` - Upon window size change  (Recommend `on`)

### History

- `cmdhist` - Save command history to `.bash_history` (Recommend is`on`)
- `compat31` - Shell 3.1 compatibility (Recommend `off`)

### Glob behavior

- `dotglob` - Description (Recommend `on`)

- `execfail` - Description (Recommend `off`)

- `expand_aliases` - Description (Recommend `on`)
- `extdebug` - Description (Recommend `off`)
- `extglob` - Description (Recommend `off`)
- `extquote` - Description (Recommend `on`)
- `failglob` - Description (Recommend `off`)
- `force_fignore` - Description (Recommend `on`)
- `gnu_errfmt` - Description (Recommend `off`)
- `histappend` - Description (Recommend `on`)
- `histreedit` - Description (Recommend `off`)
- `histverify` - Description (Recommend `off`)
- `hostcomplete` - Description (Recommend `on`)
- `huponexit` - Description (Recommend `off`)
- `interactive_comments`- Description (Recommend `on`)
- `lithist` - Description (Recommend `on`)
- `login_shell` - Description (Recommend `on`)
- `mailwarn` - Description (Recommend `off`)
- `no_empty_cmd_completion`- Description (Recommend `on`)
- `nocaseglob` - Description (Recommend `off`)
- `nocasematch` - Description (Recommend `off`)
- `nullglob` - Description (Recommend `off`)
- `progcomp` - Description (Recommend `on`)
- `promptvars` - Description (Recommend `on`)
- `restricted_shell`- Description (Recommend `off`)
- `shift_verbose` - Description (Recommend `on`)
- `sourcepath` - Description (Recommend `on`)

# Unsure

- `xpg_echo` - Description (Recommend `off`)

## `set` flags

- TODO

# Bash Problems

- `${!variable}` and `${!variable[@]}` have different semantic meanings
- No (easy) way to deference an array by another variable name
- The lack of default (empty) arrays leads to errors when doing `"${__emptyArray[@]}"` with `set -u` (and leads to ugly code like `"${__emptyArray[@]+"${__emptyArray[@]}"}"`)

[Source](https://github.com/zesk/build/docs/bash-cheatsheet.md)
