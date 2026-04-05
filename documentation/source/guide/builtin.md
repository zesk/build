# Bash Builtins

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## Input/Output

### `read`

    read: read [-ers] [-u fd] [-t timeout] [-p prompt] [-a array] [-n nchars] [-d delim] [name ...]

One line is read from the standard input, or from file descriptor `fd` if the
`-u` option is supplied, and the first word is assigned to the first `name`,
the second word to the second `name`, and so on, with leftover words assigned
to the last `name`. Only the characters found in `$IFS` are recognized as word
delimiters. If no `name`s are supplied, the line read is stored in the `REPLY`
variable. If the `-r` option is given, this signifies *raw input*, and
backslash escaping is disabled. The `-d` option causes read to continue
until the first character of `delim` is read, rather than newline. If the `-p`
option is supplied, the string `prompt` is output without a trailing newline
before attempting to read. If `-a` is supplied, the words read are assigned
to sequential indices of `array`, starting at zero. If `-e` is supplied and
the shell is interactive, readline is used to obtain the line. If `-n` is
supplied with a non-zero `nchars` argument, read returns after `nchars`
characters have been read. The `-s` option causes input coming from a
terminal to not be echoed.

The `-t` option causes read to time out and return failure if a complete line
of input is not read within `timeout` seconds. If the `TMOUT` environment variable is set,
its value is the default timeout. The return code is zero, unless end-of-file
is encountered, `read` times out, or an invalid file descriptor is supplied as
the argument to `-u`.

### `echo`

    echo [-neE] [arg ...]

Output the ARGs. If `-n` is specified, the trailing newline is
suppressed. If the `-e` option is given, interpretation of the
following backslash-escaped characters is turned on:

- `\a` - alert (bell)
- `\b` - backspace
- `\c` - suppress trailing newline
- `\E` - escape character
- `\f` - form feed
- `\n` - new line
- `\r` - carriage return
- `\t` - horizontal tab
- `\v` - vertical tab
- `\\` - backslash
- `\0nnn` - the character whose ASCII code is NNN (octal). NNN can be 0 to 3 octal digits

You can explicitly turn off the interpretation of the above characters
with the `-E` option.

### `printf`

    printf [-v var] format [arguments]

`printf` formats and prints `arguments` under control of the `format`. `format` is a character string which contains
three types of objects: plain characters, which are simply copied to standard output, character escape sequences which
are converted and copied to the standard output, and format specifications, each of which causes printing of the next
successive argument. In addition to the standard `printf(1)` formats, `%b` means to expand backslash escape sequences in
the corresponding argument, and `%q` means to quote the argument in a way that can be reused as shell input. If the `-v`
option is supplied, the output is placed into the value of the shell variable VAR rather than being sent to the standard
output.

## Shell options

### `help`

    help [-s] [pattern]

Display helpful information about builtin commands. If pattern is specified, help gives detailed help on all commands
matching pattern; otherwise help for all the builtins and shell control structures is printed. The `-s`
option restricts the information displayed to a short usage synopsis. The return status is `0` unless no command matches
pattern.

### `shopt`

    shopt [-pqsu] [-o long-option] optname [optname...]

Toggle the values of variables controlling optional behavior. The -s flag means to enable (set) each `optname`; the `-u`
flag unsets each `optname`. The `-q` flag suppresses output; the exit status indicates whether each `optname` is set or
unset. The `-o` option restricts the OPTNAMEs to those defined for use with `set -o`. With no options, or with the `-p `
option, a list of all settable options is displayed, with an indication of whether or not each is set.

- [`shopt`](./bash-cheatsheet.md)

### `shift`

    shift [n]

The positional parameters from `$n+1` ... are renamed to `$1`... If `n` is not given, it is assumed to be `1`.

### `getopts`

- TODO

### `enable`

    enable [-adnps] [-f filename] [name ...]

Enable and disable builtin shell commands. Disabling a builtin allows a disk command which has the same name as a shell
builtin to be executed without specifying a full pathname, even though the shell normally searches for
builtins before disk commands. If `-n` is used, each name is disabled; otherwise, names are enabled. For example, to use
the test binary found via the PATH instead of the shell builtin version, run `enable -n test`. The
`-f` option means to load the new builtin command name from shared object filename, on systems that support dynamic
loading. The `-d` option will delete a builtin previously loaded with `-f`. If no name arguments are given, or
if the -p option is supplied, a list of shell builtins is printed. With no other option arguments, the list consists of
all enabled shell builtins. If `-n` is supplied, only disabled builtins are printed. If `-a` is
supplied, the list printed includes all builtins, with an indication of whether or not each is enabled. If `-s` is
supplied, the output is restricted to the POSIX special builtins. The return value is 0 unless a name is not
a shell builtin or there is an error loading a new builtin from a shared object.

### `set`

- TODO

## Flow Control

### `eval`

- TODO

### `trap`

- TODO

### `exec`

### `builtin`

### `if`

### `then`

### `else`

### `elif`

### `fi`

### `return`

### `case`

### `esac`

### `for`

### `in`

### `do`

### `done`

### `until`

### `while`

### `break`

### `continue`

### `source`

Alias is `.`.

### `exit`

### `logout`

### `test`

Alias is `[`.

## Environment

## Filesystem

### `ulimit`

### `cd`

### `pwd`

### `dirs`

### `pushd`

### `popd`

### `umask`

## Variables

### `type`

### `readonly`

    readonly [-af] [name[=value] ...] 
    readonly -p

The given `name`s are marked readonly and the values of these `name`s may not be changed by subsequent assignment. If
the `-f` option is given, then functions corresponding to the `name`s are so marked. If no arguments are given, or if
`-p` is given, a list of all readonly names is printed. The `-a` option means to treat each `name` as an array variable.
An argument of `--' disables further option processing.

### `declare`

f.k.a. `typeset` which is deprecated.

### `local`

### `export`

### `set`

### `unset`

## History

### `history`

### `fc`

## Command Running

### `command`

### `hash`

    hash [-lr] [-p filename] [-dt] [name]

For each name, the full file name of the command is determined by searching the directories in `$PATH` and remembered.
If the `-p` option is supplied, no path search is performed, and filename is used as the full file name of
the command. The `-r` option causes the shell to forget all remembered locations. The `-d` option causes the shell to
forget the remembered location of each name. If the `-t` option is supplied, the full pathname to which each
name corresponds is printed. If multiple name arguments are supplied with `-t`, the name is printed before the hashed
full pathname. The `-l` option causes output to be displayed in a format that may be reused as input. If
no arguments are given, or if only `-l` is supplied, information about remembered commands is printed. The return status
is true unless a name is not found or an invalid option is supplied.

## Process Control

### `bg`

### `fg`

### `disown`

### `jobs`

### `kill`

    kill [-s sigspec | -n signum | -sigspec] pid | jobspec ... or kill -l [sigspec]

Send the processes named by `pid` (or `jobspec`) the signal `sigspec`. If `sigspec` is not present, then `sigterm` is
assumed. An argument of `-l` lists the signal names; if arguments follow `-l` they are assumed to be signal numbers for
which
names should be listed. Kill is a shell builtin for two reasons: it allows job IDs to be used instead of process IDs,
and, if you have reached the limit on processes that you can create, you don't have to start a process to kill another
one.

### `suspend`

    suspend [-f]

Suspend the execution of this shell until it receives a `SIGCONT` signal. The `-f` if specified says not to complain
about this being a login shell if it is; just suspend anyway.

### `times`

Print the accumulated user and system times for processes run from
the shell.

Example output:

    0m1.964s 0m3.152s
    1m24.234s 2m4.936s

## Completions

### `compgen`

### `complete`

### `let`

`let arg [arg ...]`

Each `arg` is an arithmetic expression to be evaluated. Evaluation is done in fixed-width integers with no check for
overflow, though
division by 0 is trapped and flagged as an error. The following list of operators is grouped into levels of
equal-precedence operators.
The levels are listed in order of decreasing precedence.

- `id++` `id--` - variable post-increment and post-decrement
- `++id` `--id` - variable pre-increment and pre-decrement
- `-` `+` - unary minus and plus
- `!` `~` - logical and bitwise negation
- `**` - exponentiation
- `*` `/` `%` - multiplication, division, remainder
- `+` `-` - addition, subtraction
- `<<` `>>` - left and right bitwise shifts
- `<=` `>=` `<` `>` - comparison
- `==` `!=` - equality and inequality
- `&` - bitwise AND
- `^` - bitwise exclusive OR
- `|` - bitwise OR
- `&&` - logical AND
- `||` - logical OR
- `expr?expr:expr` - conditional operator
- `=` `*=` `/=` `%=` `+=` `-=` `<<=` `>>=` `&=` `^=` `|=` - assignment
- `expr1 , expr2` - comma

Shell variables are allowed as operands; parameter expansion is performed before the expression is evaluated. Within an
expression, shell variables may also be referenced by name without using the parameter expansion syntax. A
shell variable that is null or unset evaluates to 0 when referenced by name without using the parameter expansion
syntax. The value of a variable is evaluated as an arithmetic expression when it is referenced, or when a variable
which has been given the integer attribute using declare -i is assigned a value. A null value evaluates to 0. A shell
variable need not have its integer attribute turned on to be used in an expression.

Constants with a leading 0 are interpreted as octal numbers. A leading `0x` or `0X` denotes hexadecimal. Otherwise,
numbers take the form `[base#]n`, where base is a decimal number between 2 and 64 representing the arithmetic base,
and n is a number in that base. If `base#` is omitted, then base 10 is used. The digits greater than 9 are represented
by the stringLowercase letters, the stringUppercase letters, @, and _, in that order. If base is less than or equal to
36,
stringLowercase and stringUppercase letters may be used interchangeably to represent numbers between 10 and 35.

Operators are evaluated in order of precedence. Sub-expressions in parentheses are evaluated first and may override the
precedence rules above.

If the last ARG evaluates to `0`, let returns `1`; `0` is returned otherwise.

## Key bindings

### `bind`

    bind [-lpvsPVS] [-m keymap] [-f filename] [-q name] [-u name] [-r keyseq] [-x keyseq:shell-command] [keyseq:readline-function or readline-command]

Bind a key sequence to a Readline function or a macro, or set
a Readline variable. The non-option argument syntax is equivalent
to that found in `~/.inputrc`, but must be passed as a single argument:

    bind '"\C-x\C-r": re-read-init-file'.

`bind` accepts the following options:

- `-m keymap` - Use `keymap' as the keymap for the duration of this command. Acceptable keymap names are emacs,
  emacs-standard, emacs-meta, emacs-ctlx, vi, vi-move,vi-command, and vi-insert.
- `-l` - List names of functions.
- `-P` - List function names and bindings.
- `-p` - List functions and bindings in a form that can be reused as input.
- `-r keyseq` - Remove the binding for KEYSEQ.
- `-x keyseq:shell-command` - Cause SHELL-COMMAND to be executed when KEYSEQ is entered.
- `-f filename` - Read key bindings from FILENAME.
- `-q function-name` - Query about which keys invoke the named function.
- `-u function-name` - Unbind all keys which are bound to the named function.
- `-V` - List variable names and values
- `-v` - List variable names and values in a form that can be reused as input.
- `-S` - List key sequences that invoke macros and their values
- `-s` - List key sequences that invoke macros and their values in a form that can be reused as input.

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
