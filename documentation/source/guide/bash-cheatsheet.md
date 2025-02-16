# bash Cheat Sheet

## Shell Options (`shopt`)

Shell options turn features within `bash` on and off interactively.

### Shell interactivity

- `cdable_vars` - Allows `cd HOME` (assumes any non-directory is the variable name) (Recommend `off`)
- `cdspell` - Attempt to fix typos in directory names on the command line (Recommend `on`)
- `interactive_comments`- Command lines that begin with `#` are comments and should be ignored. (Recommend `on`)
- `promptvars` - Enable variable substitutions in prompt displays (Recommend `on`)

### Execution path

- `checkhash` - Check whether commands found in the hash table exists before executing it. (Recommend `on`)

### Window size

- `checkwinsize` - If set, bash checks the window size after each command and, if necessary, updates the values of `LINES` and `COLUMNS`. (Recommend `on`)

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
- `nullglob` - When a pathname expansion matches no files, return an empty string instead of the pattern (Recommend `on`)

### Shell behavior

- `extquote` - Extended quotes will double-quote `$'string'` and `$"string"` within a `${parameter}` expansion. (Recommend `on`. Default is `on`.)
- `huponexit` - If set, `bash` will send `SIGHUP` to all jobs when an interactive login shell exits. (Recommend `off`)
- `execfail` - If set, a non-interactive shell will not exit if it cannot execute the file specified as an argument to the exec builtin command. An interactive shell does not exit if exec fails. (Recommend `off`)
- `mailwarn` - Shows a message about mail on login (Recommend `off`)
- `expand_aliases` - If set, aliases are expanded as described above under ALIASES. This option is enabled by default for interactive shells. (Recommend `on`)
- `gnu_errfmt` - Use GNU's error format for error messages (Recommend `off`)
- `extdebug` - Debugging features (Recommend `off`)

### Language behavior

- `nocasematch` - `case` statements are case-insensitive (Recommend `off`)
- `sourcepath` - When enabled, the `.` builtin uses the `$PATH` environment to load the file. (Recommend `on`. Default is `on`.)
- `shift_verbose` - `shift` displays an error when shifting beyond the arguments available (Recommend `on`)
- `xpg_echo` - `echo` expands backslash-escape sequences by default (Recommend `off`)
- `compat31` - Shell 3.1 compatibility (with `=~` and quotes) (Recommend `off`)

### Shell flags

- `login_shell` - Set by `bash` automatically if this shell is a login shell (Can not change)
- `restricted_shell`- This shell is restricted. (Can not change)

## `set` flags

- `-a` - Export any created or modified variables of subsequent commands
- `-b` - Report the status of terminated background jobs immediately, rather than before the next primary prompt. This is effective only when job control is enabled.
- `-e` - Exit immediately if a simple command exits with a non-zero status. A trap on ERR, if set, is executed before the shell exits.
- `-f` - Disable pathname expansion
- `-h` - Remember the location of commands as they are looked up for execution. This is enabled by default.
- `-i` - Shell is interactive.
- `-k` - All arguments in the form of assignment statements are placed in the environment for a command, not just those that precede the command name.
- `-m` - Monitor mode. Job control is enabled.
- `-n` - Read commands but do not execute them. This may be used to check a shell script for syntax errors
- `-p` - Turn on privileged mode. 
- `-t` - Exit after reading and executing one command.
- `-u` - Treat unset variables as an error when performing parameter expansion. If expansion is attempted on an unset variable, the shell prints an error message, and, if not interactive, exits with a non-zero status.
- `-v` - Print shell input lines as they are read.
- `-x` - After expanding each simple command, for command, case command, select command, or arithmetic for command, display the expanded value of PS4, followed by the command and its expanded arguments or associated word list.
- `-B` - The shell performs brace expansion (see Brace Expansion above). This is on by default.
- `-C` - If set, bash does not overwrite an existing file with the >, >&, and <> redirection operators. This may be overridden when creating output files by using the redirection operator >| instead of >.
- `-E` - If set, any trap on ERR is inherited by shell functions, command substitutions, and commands executed in a subshell environment. The ERR trap is normally not inherited in such cases.
- `-H` - Enable !  style history substitution. This option is on by default when the shell is interactive.
- `-P` - If set, the shell does not follow symbolic links when executing commands such as cd that change the current working directory. It uses the physical directory structure instead. By default, bash follows the logical chain of directories when performing commands which change the current directory.
- `-T` - If set, any traps on DEBUG and RETURN are inherited by shell functions, command substitutions, and commands executed in a subshell environment. The DEBUG and RETURN traps are normally not inherited in such cases.
- `--` - If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional parameters are set to the args, even if some of them begin with a -.
- `-` - Signal the end of options, cause all remaining args to be assigned to the positional parameters. The -x and -v options are turned off. If there are no args, the positional parameters remain unchanged.

Option names: `-o option-name`

- `allexport` - Same as `-a`.
- `braceexpand` - Same as `-B`
- `emacs` - Use an emacs-style command line editing interface. This is enabled by default when the shell is interactive, unless the shell is started with the --noediting option.
- `errtrace` - Same as `-E`.
- `functrace`                    Same as -T.
- `errexit` Same as -e.
- `hashall` Same as -h.
- `histexpand`                    Same as -H.
- `history` - Enable command history, as described above under HISTORY. This option is on by default in interactive shells.
- `ignoreeof` - The effect is as if the shell command ``IGNOREEOF=10'' had been executed (see Shell Variables above).
- `keyword` - Same as -k.
- `monitor` - Same as -m.
- `noclobber` - Same as -C.
- `noexec`  - Same as -n.
- `noglob`  - Same as -f.
- `nolog` - Currently ignored.
- `notify`  - Same as -b.
- `nounset` - Same as -u.
- `onecmd`  - Same as -t.
- `physical` - Same as -P.
- `pipefail` - If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a non-zero status, or zero if all commands in the pipeline exit successfully. This option is disabled by default.
- `posix` - Change the behavior of bash where the default operation differs from the POSIX standard to match the standard (posix mode).
- `privileged` - Same as -p.
- `verbose` Same as -v.
- `vi` - Use a vi-style command line editing interface.
- `xtrace` - Same as -x.

If -o is supplied with no option-name, the values of the current options are printed. If +o is supplied with no option-name, a series of set commands to recreate the current option settings is displayed on the standard output.

The options are off by default unless otherwise noted. Using + rather than - causes these options to be turned off. The options can also be specified as arguments to an invocation of the shell. The current set of options may be found in `$-`. The return status is always true unless an invalid option is encountered.

### Privileged Mode

In this mode, the `$ENV` and `$BASH_ENV` files are not processed, shell functions are not inherited from the environment, and the `SHELLOPTS` variable, if it appears in the environment, is ignored. If the shell is started with the effective user (group) id not equal to the real user (group) id, and the `-p` option is not supplied,
these actions are taken and the effective user id is set to the real user id. If the `-p` option is supplied at startup, the effective user id is not reset. Turning this option off causes the effective user and group ids to be set to the real user and group ids.

# Bash Problems

- `${!variable}` and `${!variable[@]}` have different semantic meanings
- No (easy) way to deference an array by another variable name
- The lack of default (empty) arrays leads to errors when doing `"${__emptyArray[@]}"` with `set -u` (and leads to ugly code like `"${__emptyArray[@]+"${__emptyArray[@]}"}"`)

[Source](https://github.com/zesk/build/docs/bash-cheatsheet.md)
