# Set Cheatsheet

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## `set` flags

- `-a` - Export any created or modified variables of subsequent commands
- `-b` - Report the status of terminated background jobs immediately, rather than before the next primary prompt. This
  is effective only when job control is enabled.
- `-e` - Exit immediately if a simple command exits with a non-zero status. A trap on ERR, if set, is executed before
  the shell exits.
- `-f` - Disable pathname expansion
- `-h` - Remember the location of commands as they are looked up for execution. This is enabled by default.
- `-i` - Shell is interactive.
- `-k` - All arguments in the form of assignment statements are placed in the environment for a command, not just those
  that precede the command name.
- `-m` - Monitor mode. Job control is enabled.
- `-n` - Read commands but do not execute them. This may be used to check a shell script for syntax errors
- `-p` - Turn on privileged mode.
- `-t` - Exit after reading and executing one command.
- `-u` - Treat unset variables as an error when performing parameter expansion. If expansion is attempted on an unset
  variable, the shell prints an error message, and, if not interactive, exits with a non-zero status.
- `-v` - Print shell input lines as they are read.
- `-x` - After expanding each simple command, for command, case command, select command, or arithmetic for command,
  display the expanded value of PS4, followed by the command and its expanded arguments or associated word list.
- `-B` - The shell performs brace expansion (see Brace Expansion above). This is on by default.
- `-C` - If set, bash does not overwrite an existing file with the >, >&, and <> redirection operators. This may be
  overridden when creating output files by using the redirection operator >| instead of >.
- `-E` - If set, any trap on ERR is inherited by shell functions, command substitutions, and commands executed in a
  subshell environment. The ERR trap is normally not inherited in such cases.
- `-H` - Enable !  style history substitution. This option is on by default when the shell is interactive.
- `-P` - If set, the shell does not follow symbolic links when executing commands such as cd that change the current
  working directory. It uses the physical directory structure instead. By default, bash follows the logical chain of
  directories when performing commands which change the current directory.
- `-T` - If set, any traps on DEBUG and RETURN are inherited by shell functions, command substitutions, and commands
  executed in a subshell environment. The DEBUG and RETURN traps are normally not inherited in such cases.
- `--` - If no arguments follow this option, then the positional parameters are unset. Otherwise, the positional
  parameters are set to the args, even if some of them begin with a -.
- `-` - Signal the end of options, cause all remaining args to be assigned to the positional parameters. The -x and -v
  options are turned off. If there are no args, the positional parameters remain unchanged.

The following flags are "sticky" and will remain in parent functions after a function exits:

- `-a` `-b` `-f` `-m` `-p` `-k` `-C` `-T`

The following flags are scoped to the current function and are unset upon exit to the prior function scope setting:

- `-e`, `-E`, `-u`

All settings inherit to called functions.

Option names: `-o option-name`

- `allexport` - Same as `-a`.
- `braceexpand` - Same as `-B`
- `emacs` - Use an emacs-style command line editing interface. This is enabled by default when the shell is interactive,
  unless the shell is started with the `--noediting` option.
- `errtrace` - Same as `-E`.
- `functrace` - Same as `-T`.
- `errexit`- Same as `-e`.
- `hashall`- Same as `-h`.
- `histexpand` - Same as `-H`.
- `history` - Enable command history, as described above under HISTORY. This option is on by default in interactive
  shells.
- `ignoreeof` - The effect is as if the shell command ``IGNOREEOF=10'' had been executed (see Shell Variables above).
- `keyword` - Same as `-k`.
- `monitor` - Same as `-m`.
- `noclobber` - Same as `-C`.
- `noexec`  - Same as `-n`.
- `noglob`  - Same as `-f`.
- `nolog` - Currently ignored.
- `notify`  - Same as `-b`.
- `nounset` - Same as `-u`.
- `onecmd`  - Same as `-t`.
- `physical` - Same as `-P`.
- `pipefail` - If set, the return value of a pipeline is the value of the last (rightmost) command to exit with a
  non-zero status, or zero if all commands in the pipeline exit successfully. This option is disabled by default.
- `posix` - Change the behavior of bash where the default operation differs from the POSIX standard to match the
  standard (posix mode).
- `privileged` - Same as `-p`.
- `verbose` Same as `-v`.
- `vi` - Use a vi-style command line editing interface.
- `xtrace` - Same as `-x`.

If `-o` is supplied with no option-name, the values of the current options are printed. If `+o` is supplied with no
option-name, a series of set commands to recreate the current option settings is displayed on the standard output.

The options are off by default unless otherwise noted. Using + rather than - causes these options to be turned off. The
options can also be specified as arguments to an invocation of the shell. The current set of options may be found in
`$-`. The return status is always true unless an invalid option is encountered.


## Appendix: `set -o` output (February 2026):

    allexport      	off
    braceexpand    	on
    emacs          	on
    errexit        	off
    errtrace       	off
    functrace      	off
    hashall        	on
    histexpand     	on
    history        	on
    ignoreeof      	off
    interactive-comments	on
    keyword        	off
    monitor        	on
    noclobber      	off
    noexec         	off
    noglob         	off
    nolog          	off
    notify         	off
    nounset        	off
    onecmd         	off
    physical       	off
    pipefail       	off
    posix          	off
    privileged     	off
    verbose        	off
    vi             	off
    xtrace         	off

<!-- TEMPLATE guideFooter 2 -->
<hr />
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
