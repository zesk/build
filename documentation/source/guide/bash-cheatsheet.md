# bash Cheat Sheet

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## Function names and special characters

The following are all permitted in function names in addition to `[A-Z0-9a-z_]`:

    - "+", ".", "/", ":", "=", "?", "@", "", "", "^", "_", "{", "}", "~", and even some Unicode symbols

However, for portability with POSIX or other shell implementations it is not recommended.

## Shell Options (`shopt`)

Shell options turn features within `bash` on and off interactively.

- `shopt -s` - Set the option (enable it)
- `shopt -u` - Unset the option (disable it)

### Shell interactivity

- `cdable_vars` - Allows `cd HOME` (assumes any non-directory is the variable name) (Recommend `off`)
- `cdspell` - Attempt to fix typos in directory names on the command line (Recommend `on`)
- `interactive_comments`- Command lines that begin with `#` are comments and should be ignored. (Recommend `on`)
- `promptvars` - Enable variable substitutions in prompt displays (Recommend `on`)

### Execution path

- `checkhash` - Check whether commands found in the hash table exists before executing it. (Recommend `on`)

### Window size

- `checkwinsize` - If set, bash checks the window size after each command and, if necessary, updates the values of
  `LINES` and `COLUMNS`. (Recommend `on`)

### History

- `cmdhist` - Save command history to `.bash_history` (Recommend is`on`)
- `histappend` - When updating `bash` history, append to the file instead of overwriting it (Recommend `on`)
- `histreedit` - User can edit failed history substitutions when `readline` is used (Recommend `off`)
- `histverify` - Allow additional editing of history results prior to execution using `readline` (Recommend `off`)
- `lithist` - Embed newlines in history entries to ensure commands are stored as one line (Recommend `on`)

### Completions

- `force_fignore` - Ignore `FIGNORE` expansions even when it is the only match (Recommend `on`)
- `hostcomplete` - When user types `@` on the command line attempt to complete the hostname (Recommend `off`)
- `no_empty_cmd_completion`- Do not attempt a completion for an empty line (Recommend `on`)
- `progcomp` - Programmable completion is enabled (Recommend `on`)

### Glob behavior

- `dotglob` - Files that start with `.` are included in pathname expansion (Recommend `on`)
- `extglob` - Extended pattern matching for pathname expansion is enabled (Recommend `off`)
- `failglob` - Bash will produce an error when a pathname expansion matches no files (Recommend `off`)
- `nocaseglob` - Pathname expansion is case-insensitive (Recommend `off`)
- `nullglob` - When a pathname expansion matches no files, return an empty string instead of the pattern (Recommend
  `on`)

### Shell behavior

- `extquote` - Extended quotes will double-quote `$'string'` and `$"string"` within a `$parameter` expansion. (
  Recommend `on`. Default is `on`.)
- `huponexit` - If set, `bash` will send `SIGHUP` to all jobs when an interactive login shell exits. (Recommend `off`)
- `execfail` - If set, a non-interactive shell will not exit if it cannot execute the file specified as an argument to
  the exec builtin command. An interactive shell does not exit if exec fails. (Recommend `off`)
- `mailwarn` - Shows a message about mail on login (Recommend `off`)
- `expand_aliases` - If set, aliases are expanded as described above under ALIASES. This option is enabled by default
  for interactive shells. (Recommend `on`)
- `gnu_errfmt` - Use GNU's error format for error messages (Recommend `off`)
- `extdebug` - Debugging features (Recommend `off`)

### Language behavior

- `nocasematch` - `case` statements are case-insensitive (Recommend `off`)
- `sourcepath` - When enabled, the `.` builtin uses the `$PATH` environment to load the file. (Recommend `on`. Default
  is `on`.)
- `shift_verbose` - `shift` displays an error when shifting beyond the arguments available (Recommend `on`)
- `xpg_echo` - `echo` expands backslash-escape sequences by default (Recommend `off`)
- `compat31` - Shell 3.1 compatibility (with `=~` and quotes) (Recommend `off`)

### Shell flags

- `login_shell` - Set by `bash` automatically if this shell is a login shell (Can not change)
- `restricted_shell`- This shell is restricted. (Can not change)

### Set Flags

See [set cheatsheet](./set-cheatsheet.md).

### Privileged Mode

In this mode, the `$ENV` and `$BASH_ENV` files are not processed, shell functions are not inherited from the
environment, and the `SHELLOPTS` variable, if it appears in the environment, is ignored. If the shell is started with
the effective user (group) id not equal to the real user (group) id, and the `-p` option is not supplied,
these actions are taken and the effective user id is set to the real user id. If the `-p` option is supplied at startup,
the effective user id is not reset. Turning this option off causes the effective user and group ids to be set to the
real user and group ids.

# Bash Problems

- `${!variable}` and `${!variable[@]}` have different semantic meanings
- No (easy) way to deference an array by another variable name
- The lack of default (empty) arrays leads to errors when doing `"${__emptyArray[@]}"` with `set -u` (and leads to ugly
  code like `"${__emptyArray[@]+"${__emptyArray[@]}"}"`)
- `read` exits 0 on end of file but actually may return a string leading to issues with missing newlines causing
  problems; use the pattern: `local finished=false; while ! $finished; do read -r line || finished=true; ...` and then
  test the
  value of `line` for non-empty values and handle when `$finished` becomes `true`.
  [Source](https://github.com/zesk/build/docs/bash-cheatsheet.md)
- Problems with `&&` or `||` precedence leads to errors

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
