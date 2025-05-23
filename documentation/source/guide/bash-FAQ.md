This is the Bash FAQ, version 4.15, for Bash version 5.1.

[This document is no longer maintained.]

This document contains a set of frequently-asked questions concerning
Bash, the GNU Bourne-Again Shell. Bash is a freely-available command
interpreter with advanced features for both interactive use and shell
programming.

Another good source of basic information about shells is the collection
of FAQ articles periodically posted to comp.unix.shell.

Questions and comments concerning this document should be sent to
chet.ramey@case.edu.

This document is available for anonymous FTP with the URL

ftp://ftp.cwru.edu/pub/bash/FAQ

The Bash home page is http://cnswww.cns.cwru.edu/~chet/bash/bashtop.html

----------
Contents:

Section A:  The Basics

A1) What is it?
A2) What's the latest version?
A3) Where can I get it?
A4) On what machines will bash run?
A5) Will bash run on operating systems other than Unix?
A6) How can I build bash with gcc?
A7) How can I make bash my login shell?
A8) I just changed my login shell to bash, and now I can't FTP into my
machine. Why not?
A9) What's the `POSIX Shell and Utilities standard'?
A10) What is the bash `posix mode'?

Section B:  The latest version

B1) What's new in version 4.3?
B2) Are there any user-visible incompatibilities between bash-4.3 and
previous bash versions?

Section C:  Differences from other Unix shells

C1) How does bash differ from sh, the Bourne shell?
C2) How does bash differ from the Korn shell, version ksh88?
C3) Which new features in ksh-93 are not in bash, and which are?

Section D:  Why does bash do some things differently than other Unix shells?

D1) Why does bash run a different version of `command' than
    `which command' says it will?
D2) Why doesn't bash treat brace expansions exactly like csh?
D3) Why doesn't bash have csh variable modifiers?
D4) How can I make my csh aliases work when I convert to bash?
D5) How can I pipe standard output and standard error from one command to
another, like csh does with `|&'?
D6) Now that I've converted from ksh to bash, are there equivalents to
    ksh features like autoloaded functions and the `whence' command?

Section E:  Why does bash do certain things the way it does?

E1) Why is the bash builtin `test' slightly different from /bin/test?
E2) Why does bash sometimes say `Broken pipe'?
E3) When I have terminal escape sequences in my prompt, why does bash
wrap lines at the wrong column?
E4) If I pipe the output of a command into `read variable', why doesn't
    the output show up in $variable when the read command finishes?
E5) I have a bunch of shell scripts that use backslash-escaped characters
    in arguments to `echo'. Bash doesn't interpret these characters. Why
not, and how can I make it understand them?
E6) Why doesn't a while or for loop get suspended when I type ^Z?
E7) What about empty for loops in Makefiles?
E8) Why does the arithmetic evaluation code complain about `08'?
E9) Why does the pattern matching expression [A-Z]* match files beginning
    with every letter except `z'?
E10) Why does `cd //' leave $PWD as `//'?
E11) If I resize my xterm while another program is running, why doesn't bash
notice the change?
E12) Why don't negative offsets in substring expansion work like I expect?
E13) Why does filename completion misbehave if a colon appears in the filename?
E14) Why does quoting the pattern argument to the regular expression matching
conditional operator (=~) cause matching to stop working?
E15) Tell me more about the shell compatibility level.

Section F:  Things to watch out for on certain Unix versions

F1) Why can't I use command line editing in my `cmdtool'?
F2) I built bash on Solaris 2.  Why do globbing expansions and filename
    completion chop off the first few characters of each filename?
F3) Why does bash dump core after I interrupt username completion or
    `~user' tilde expansion on a machine running NIS?
F4) I'm running SVR4.2. Why is the line erased every time I type `@'?
F5) Why does bash report syntax errors when my C News scripts use a
    redirection before a subshell command?
F6) Why can't I use vi-mode editing on Red Hat Linux 6.1?
F7) Why do bash-2.05a and  bash-2.05b fail to compile `printf.def' on
HP/UX 11.x?

Section G:  How can I get bash to do certain common things?

G1) How can I get bash to read and display eight-bit characters?
G2) How do I write a function `x' to replace builtin command `x', but
still invoke the command from within the function?
G3) How can I find the value of a shell variable whose name is the value
of another shell variable?
G4) How can I make the bash `time' reserved word print timing output that
looks like the output from my system's /usr/bin/time?
G5) How do I get the current directory into my prompt?
G6) How can I rename "*.foo" to "*.bar"?
G7) How can I translate a filename from uppercase to lowercase?
G8) How can I write a filename expansion (globbing) pattern that will match
all files in the current directory except "." and ".."?

Section H:  Where do I go from here?

H1) How do I report bugs in bash, and where should I look for fixes and
advice?
H2) What kind of bash documentation is there?
H3) What's coming in future versions?
H4) What's on the bash `wish list'?
H5) When will the next release appear?

----------
Section A:  The Basics

A1)  What is it?

Bash is a Unix command interpreter (shell). It is an implementation of
the Posix 1003.2 shell standard, and resembles the Korn and System V
shells.

Bash contains a number of enhancements over those shells, both
for interactive use and shell programming. Features geared
toward interactive use include command line editing, command
history, job control, aliases, and prompt expansion. Programming
features include additional variable expansions, shell
arithmetic, and a number of variables and options to control
shell behavior.

Bash was originally written by Brian Fox of the Free Software
Foundation. The current developer and maintainer is Chet Ramey
of Case Western Reserve University.

A2)  What's the latest version?

The latest version is 4.3, first made available on 26 February, 2014.

A3)  Where can I get it?

Bash is the GNU project's shell, and so is available from the
master GNU archive site, ftp.gnu.org, and its mirrors. The
latest version is also available for FTP from ftp.cwru.edu.
The following URLs tell how to get version 4.3:

ftp://ftp.gnu.org/pub/gnu/bash/bash-4.3.tar.gz
ftp://ftp.cwru.edu/pub/bash/bash-4.3.tar.gz

Formatted versions of the documentation are available with the URLs:

ftp://ftp.gnu.org/pub/gnu/bash/bash-doc-4.3.tar.gz
ftp://ftp.cwru.edu/pub/bash/bash-doc-4.3.tar.gz

Any patches for the current version are available with the URL:

ftp://ftp.cwru.edu/pub/bash/bash-4.3-patches/

A4)  On what machines will bash run?

Bash has been ported to nearly every version of Unix. All you
should have to do to build it on a machine for which a port
exists is to type `configure' and then `make'. The build process
will attempt to discover the version of Unix you have and tailor
itself accordingly, using a script created by GNU autoconf.

More information appears in the file `INSTALL' in the distribution.

The Bash web page (http://cnswww.cns.cwru.edu/~chet/bash/bashtop.html)
explains how to obtain binary versions of bash for most of the major
commercial Unix systems.

A5) Will bash run on operating systems other than Unix?

Configuration specifics for Unix-like systems such as QNX and
LynxOS are included in the distribution. Bash-2.05 and later
versions should compile and run on Minix 2.0 (patches were
contributed), but I don't believe anyone has built bash-2.x on
earlier Minix versions yet.

Bash has been ported to versions of Windows implementing the Win32
programming interface. This includes Windows 95 and Windows NT.
The port was done by Cygnus Solutions (now part of Red Hat) as part
of their CYGWIN project. For more information about the project, see
http://www.cygwin.com/.

Cygnus originally ported bash-1.14.7, and that port was part of their
early GNU-Win32 (the original name) releases. Cygnus has also done
ports of bash-3.2 and bash-4.0 to the CYGWIN environment, and both
are available as part of their current release.

Bash-2.05b and later versions should require no local Cygnus changes to
build and run under CYGWIN.

DJ Delorie has a port of bash-2.x which runs under MS-DOS, as part
of the DJGPP project. For more information on the project, see

http://www.delorie.com/djgpp/

I have been told that the original DJGPP port was done by Daisuke Aoyama.

Mark Elbrecht <snowball3@bigfoot.com> has sent me notice that bash-2.04
is available for DJGPP V2. The files are available as:

ftp://ftp.simtel.net/pub/simtelnet/gnu/djgpp/v2gnu/bsh204b.zip    binary
ftp://ftp.simtel.net/pub/simtelnet/gnu/djgpp/v2gnu/bsh204d.zip    documentation
ftp://ftp.simtel.net/pub/simtelnet/gnu/djgpp/v2gnu/bsh204s.zip    source

Mark began to work with bash-2.05, but I don't know the current status.

Bash-3.0 compiles and runs with no modifications under Microsoft's Services
for Unix (SFU), once known as Interix. I do not anticipate any problems
with building bash-4.2 and later, but will gladly accept any patches that
are needed.

A6) How can I build bash with gcc?

Bash configures to use gcc by default if it is available. Read the
file INSTALL in the distribution for more information.

A7)  How can I make bash my login shell?

Some machines let you use `chsh' to change your login shell.  Other
systems use `passwd -s' or `passwd -e'. If one of these works for
you, that's all you need. Note that many systems require the full
pathname to a shell to appear in /etc/shells before you can make it
your login shell. For this, you may need the assistance of your
friendly local system administrator.

If you cannot do this, you can still use bash as your login shell, but
you need to perform some tricks. The basic idea is to add a command
to your login shell's startup file to replace your login shell with
bash.

For example, if your login shell is csh or tcsh, and you have installed
bash in /usr/gnu/bin/bash, add the following line to ~/.login:

	if ( -f /usr/gnu/bin/bash ) exec /usr/gnu/bin/bash --login

(the `--login' tells bash that it is a login shell).

It's not a good idea to put this command into ~/.cshrc, because every
csh you run without the `-f' option, even ones started to run csh scripts,
reads that file. If you must put the command in ~/.cshrc, use something
like

	if ( $?prompt ) exec /usr/gnu/bin/bash --login

to ensure that bash is exec'd only when the csh is interactive.

If your login shell is sh or ksh, you have to do two things.

First, create an empty file in your home directory named `.bash_profile'.
The existence of this file will prevent the exec'd bash from trying to
read ~/.profile, and re-execing itself over and over again.  ~/.bash_profile
is the first file bash tries to read initialization commands from when
it is invoked as a login shell.

Next, add a line similar to the above to ~/.profile:

	[ -f /usr/gnu/bin/bash ] && [ -x /usr/gnu/bin/bash ] && \
		exec /usr/gnu/bin/bash --login

This will cause login shells to replace themselves with bash running as
a login shell. Once you have this working, you can copy your initialization
code from ~/.profile to ~/.bash_profile.

I have received word that the recipe supplied above is insufficient for
machines running CDE. CDE has a maze of twisty little startup files, all
slightly different.

If you cannot change your login shell in the password file to bash, you
will have to (apparently) live with CDE using the shell in the password
file to run its startup scripts. If you have changed your shell to bash,
there is code in the CDE startup files (on Solaris, at least) that attempts
to do the right thing. It is, however, often broken, and may require that
you use the $BASH_ENV trick described below.

`dtterm' claims to use $SHELL as the default program to start, so if you
can change $SHELL in the CDE startup files, you should be able to use bash
in your terminal windows.

Setting DTSOURCEPROFILE in ~/.dtprofile will cause the `Xsession' program
to read your login shell's startup files. You may be able to use bash for
the rest of the CDE programs by setting SHELL to bash in ~/.dtprofile as
well, but I have not tried this.

You can use the above `exec' recipe to start bash when not logging in with
CDE by testing the value of the DT variable:

	if [ -n "$DT" ]; then
	        [ -f /usr/gnu/bin/bash ] && exec /usr/gnu/bin/bash --login
	fi

If CDE starts its shells non-interactively during login, the login shell
startup files (~/.profile, ~/.bash_profile) will not be sourced at login.
To get around this problem, append a line similar to the following to your
~/.dtprofile:

	BASH_ENV=${HOME}/.bash_profile ; export BASH_ENV

and add the following line to the beginning of ~/.bash_profile:

	unset BASH_ENV

A8) I just changed my login shell to bash, and now I can't FTP into my
machine. Why not?

You must add the full pathname to bash to the file /etc/shells. As
noted in the answer to the previous question, many systems require
this before you can make bash your login shell.

Most versions of ftpd use this file to prohibit `special' users
such as `uucp' and `news' from using FTP.

A9)  What's the `POSIX Shell and Utilities standard'?

POSIX is a name originally coined by Richard Stallman for a
family of open system standards based on UNIX. There are a
number of aspects of UNIX under consideration for
standardization, from the basic system services at the system
call and C library level to applications and tools to system
administration and management. Each area of standardization is
assigned to a working group in the 1003 series.

The POSIX Shell and Utilities standard was originally developed by
IEEE Working Group 1003.2 (POSIX.2). Today it has been merged with
the original 1003.1 Working Group and is maintained by the Austin
Group (a joint working group of the IEEE, The Open Group and
ISO/IEC SC22/WG15). Today the Shell and Utilities are a volume
within the set of documents that make up IEEE Std 1003.1-2001, and
thus now the former POSIX.2 (from 1992) is now part of the current
POSIX.1 standard (POSIX 1003.1-2001).

The Shell and Utilities volume concentrates on the command
interpreter interface and utility programs commonly executed from
the command line or by other programs. The standard is freely
available on the web at http://www.UNIX-systems.org/version3/ .
Work continues at the Austin Group on maintenance issues; see
http://www.opengroup.org/austin/ to join the discussions.

Bash is concerned with the aspects of the shell's behavior defined
by the POSIX Shell and Utilities volume. The shell command
language has of course been standardized, including the basic flow
control and program execution constructs, I/O redirection and
pipelining, argument handling, variable expansion, and quoting.

The `special' builtins, which must be implemented as part of the
shell to provide the desired functionality, are specified as
being part of the shell; examples of these are `eval' and
`export'.  Other utilities appear in the sections of POSIX not
devoted to the shell which are commonly (and in some cases must
be) implemented as builtin commands, such as `read' and `test'.
POSIX also specifies aspects of the shell's interactive
behavior as part of the UPE, including job control and command
line editing. Only vi-style line editing commands have been
standardized; emacs editing commands were left out due to
objections.

The latest version of the POSIX Shell and Utilities standard is
available (now updated to the 2004 Edition) as part of the Single
UNIX Specification Version 3 at

http://www.UNIX-systems.org/version3/

A10)  What is the bash `posix mode'?

Although bash is an implementation of the POSIX shell
specification, there are areas where the bash default behavior
differs from that spec. The bash `posix mode' changes the bash
behavior in these areas so that it obeys the spec more closely.

Posix mode is entered by starting bash with the --posix or
'-o posix' option or executing `set -o posix' after bash is running.

The specific aspects of bash which change when posix mode is
active are listed in the file POSIX in the bash distribution.
They are also listed in a section in the Bash Reference Manual
(from which that file is generated).

Section B:  The latest version

B1) What's new in version 4.3?

Bash-4.3 is the third revision to the fourth major release of bash.

Bash-4.3 contains the following new features (see the manual page for
complete descriptions and the CHANGES and NEWS files in the bash-4.3
distribution):

o The `helptopic' completion action now maps to all the help topics, not just
the shell builtins.

o The `help' builtin no longer does prefix substring matching first, so
   `help read' does not match `readonly', but will do it if exact string
matching fails.

o The shell can be compiled to not display a message about processes that
terminate due to SIGTERM.

o Non-interactive shells now react to the setting of checkwinsize and set
LINES and COLUMNS after a foreground job exits.

o There is a new shell option, `globasciiranges', which, when set to on,
forces globbing range comparisons to use character ordering as if they
were run in the C locale.

o There is a new shell option, `direxpand', which makes filename completion
expand variables in directory names in the way bash-4.1 did.

o In Posix mode, the `command' builtin does not change whether or not a
builtin it shadows is treated as an assignment builtin.

o The `return' and `exit' builtins accept negative exit status arguments.

o The word completion code checks whether or not a filename containing a
shell variable expands to a directory name and appends `/' to the word
as appropriate. The same code expands shell variables in command names
when performing command completion.

o In Posix mode, it is now an error to attempt to define a shell function
with the same name as a Posix special builtin.

o When compiled for strict Posix conformance, history expansion is disabled
by default.

o The history expansion character (!) does not cause history expansion when
followed by the closing quote in a double-quoted string.

o  `complete' and its siblings compgen/compopt now takes a new `-o noquote'
option to inhibit quoting of the completions.

o Setting HISTSIZE to a value less than zero causes the history list to be
unlimited (setting it 0 zero disables the history list).

o Setting HISTFILESIZE to a value less than zero causes the history file size
to be unlimited (setting it to 0 causes the history file to be truncated
to zero size).

o The `read' builtin now skips NUL bytes in the input.

o There is a new `bind -X' option to print all key sequences bound to Unix
commands.

o When in Posix mode, `read' is interruptible by a trapped signal. After
running the trap handler, read returns 128+signal and throws away any
partially-read input.

o The command completion code skips whitespace and assignment statements
before looking for the command name word to be completed.

o The build process has a new mechanism for constructing separate help files
that better reflects the current set of compilation options.

o The -nt and -ot options to test now work with files with nanosecond
timestamp resolution.

o The shell saves the command history in any shell for which history is
enabled and HISTFILE is set, not just interactive shells.

o The shell has `nameref' variables and new -n(/+n) options to declare and
   unset to use them, and a `test -R' option to test for them.

o The shell now allows assigning, referencing, and unsetting elements of
indexed arrays using negative subscripts (a[-1]=2, echo ${a[-1]}) which
count back from the last element of the array.

o The {x}<word redirection feature now allows words like {array[ind]} and
can use variables with special meanings to the shell (e.g., BASH_XTRACEFD).

o There is a new CHILD_MAX special shell variable; its value controls the
number of exited child statues the shell remembers.

o There is a new configuration option (--enable-direxpand-default) that
causes the `direxpand' shell option to be enabled by default.

o Bash does not do anything special to ensure that the file descriptor
assigned to X in {x}<foo remains open after the block containing it
completes.

o The `wait' builtin has a new `-n' option to wait for the next child to
change status.

o The `printf' %(...)T format specifier now uses the current time if no
argument is supplied.

o There is a new variable, BASH_COMPAT, that controls the current shell
compatibility level.

o The `popd' builtin now treats additional arguments as errors.

o The brace expansion code now treats a failed sequence expansion as a
simple string and will continue to expand brace terms in the remainder
of the word.

o Shells started to run process substitutions now run any trap set on EXIT.

o The fc builtin now interprets -0 as the current command line.

o Completing directory names containing shell variables now adds a trailing
slash if the expanded result is a directory.

A short feature history dating back to Bash-2.0:

Bash-4.2 contained the following new features:

o   `exec -a foo' now sets $0 to `foo' in an executable shell script without a
leading #!.

o Subshells begun to execute command substitutions or run shell functions or
builtins in subshells do not reset trap strings until a new trap is
specified. This allows $(trap) to display the caller's traps and the
trap strings to persist until a new trap is set.

o   `trap -p' will now show signals ignored at shell startup, though their
disposition still cannot be modified.

o   $'...', echo, and printf understand \uXXXX and \UXXXXXXXX escape sequences.

o declare/typeset has a new `-g' option, which creates variables in the
global scope even when run in a shell function.

o test/[/[[ have a new -v variable unary operator, which returns success if
`variable' has been set.

o Posix parsing changes to allow `! time command' and multiple consecutive
    instances of `!' (which toggle) and `time' (which have no cumulative
effect).

o Posix change to allow `time' as a command by itself to print the elapsed
user, system, and real times for the shell and its children.

o   $((...)) is always parsed as an arithmetic expansion first, instead of as
a potential nested command substitution, as Posix requires.

o A new FUNCNEST variable to allow the user to control the maximum shell
function nesting (recursive execution) level.

o The mapfile builtin now supplies a third argument to the callback command:
the line about to be assigned to the supplied array index.

o The printf builtin has as new %(fmt)T specifier, which allows time values
to use strftime-like formatting.

o There is a new `compat41' shell option.

o The cd builtin has a new Posix-mandated `-e' option.

o Negative subscripts to indexed arrays, previously errors, now are treated
as offsets from the maximum assigned index + 1.

o Negative length specifications in the ${var:offset:length} expansion,
previously errors, are now treated as offsets from the end of the variable.

o Parsing change to allow `time -p --'.

o Posix-mode parsing change to not recognize `time' as a keyword if the
    following token begins with a `-'. This means no more Posix-mode
`time -p'. Posix interpretation 267.

o There is a new `lastpipe' shell option that runs the last command of a
pipeline in the current shell context. The lastpipe option has no
effect if job control is enabled.

o History expansion no longer expands the `$!' variable expansion.

o Posix mode shells no longer exit if a variable assignment error occurs
with an assignment preceding a command that is not a special builtin.

o Non-interactive mode shells exit if -u is enabled an an attempt is made
to use an unset variable with the % or # expansions, the `//', `^', or
`,' expansions, or the parameter length expansion.

o Posix-mode shells use the argument passed to `.' as-is if a $PATH search
fails, effectively searching the current directory. Posix-2008 change.

A short feature history dating back to Bash-2.0:

Bash-4.1 contained the following new features:

o Here-documents within $(...) command substitutions may once more be
delimited by the closing right paren, instead of requiring a newline.

o Bash's file status checks (executable, readable, etc.) now take file
system ACLs into account on file systems that support them.

o Bash now passes environment variables with names that are not valid
shell variable names through into the environment passed to child
processes.

o The `execute-unix-command' readline function now attempts to clear and
reuse the current line rather than move to a new one after the command
executes.

o   `printf -v' can now assign values to array indices.

o New `complete -E' and `compopt -E' options that work on the "empty"
completion: completion attempted on an empty command line.

o New complete/compgen/compopt -D option to define a `default' completion:
a completion to be invoked on command for which no completion has been
defined. If this function returns 124, programmable completion is
attempted again, allowing a user to dynamically build a set of completions
as completion is attempted by having the default completion function
install individual completion functions each time it is invoked.

o When displaying associative arrays, subscripts are now quoted.

o Changes to dabbrev-expand to make it more `emacs-like': no space appended
after matches, completions are not sorted, and most recent history entries
are presented first.

o The [[ and (( commands are now subject to the setting of `set -e' and the
ERR trap.

o The source/. builtin now removes NUL bytes from the file before attempting
to parse commands.

o There is a new configuration option (in config-top.h) that forces bash to
forward all history entries to syslog.

o A new variable $BASHOPTS to export shell options settable using `shopt' to
child processes.

o There is a new confgure option that forces the extglob option to be
enabled by default.

o New variable $BASH_XTRACEFD; when set to an integer bash will write xtrace
output to that file descriptor.

o If the optional left-hand-side of a redirection is of the form {var}, the
shell assigns the file descriptor used to $var or uses $var as the file
descriptor to move or close, depending on the redirection operator.

o The < and > operators to the [[ conditional command now do string
comparison according to the current locale.

o Programmable completion now uses the completion for `b' instead of `a'
when completion is attempted on a line like: a $(b c.

o Force extglob on temporarily when parsing the pattern argument to
the == and != operators to the [[ command, for compatibility.

o Changed the behavior of interrupting the wait builtin when a SIGCHLD is
received and a trap on SIGCHLD is set to be Posix-mode only.

o The read builtin has a new `-N nchars' option, which reads exactly NCHARS
characters, ignoring delimiters like newline.

o The mapfile/readarray builtin no longer stores the commands it invokes via
callbacks in the history list.

o There is a new `compat40' shopt option.

o The < and > operators to [[ do string comparisons using the current locale
only if the compatibility level is greater than 40 (set to 41 by default).

o New bindable readline function: menu-complete-backward.

o In the readline vi-mode insertion keymap, C-n is now bound to menu-complete
by default, and C-p to menu-complete-backward.

o When in readline vi command mode, repeatedly hitting ESC now does nothing,
even when ESC introduces a bound key sequence. This is closer to how
historical vi behaves.

o New bindable readline function: skip-csi-sequence. Can be used as a
default to consume key sequences generated by keys like Home and End
without having to bind all keys.

o New bindable readline variable: skip-completed-text, active when
completing in the middle of a word. If enabled, it means that characters
in the completion that match characters in the remainder of the word are
"skipped" rather than inserted into the line.

o The pre-readline-6.0 version of menu completion is available as
"old-menu-complete" for users who do not like the readline-6.0 version.

o New bindable readline variable: echo-control-characters. If enabled, and
the tty ECHOCTL bit is set, controls the echoing of characters
corresponding to keyboard-generated signals.

o New bindable readline variable: enable-meta-key. Controls whether or not
readline sends the smm/rmm sequences if the terminal indicates it has a
meta key that enables eight-bit characters.

Bash-4.0 contained the following new features:

o When using substring expansion on the positional parameters, a starting
index of 0 now causes $0 to be prefixed to the list.

o There is a new variable, $BASHPID, which always returns the process id of
the current shell.

o There is a new `autocd' option that, when enabled, causes bash to attempt
    to `cd' to a directory name that is supplied as the first word of a
simple command.

o There is a new `checkjobs' option that causes the shell to check for and
report any running or stopped jobs at exit.

o The programmable completion code exports a new COMP_TYPE variable, set to
a character describing the type of completion being attempted.

o The programmable completion code exports a new COMP_KEY variable, set to
the character that caused the completion to be invoked (e.g., TAB).

o The programmable completion code now uses the same set of characters as
readline when breaking the command line into a list of words.

o The block multiplier for the ulimit -c and -f options is now 512 when in
Posix mode, as Posix specifies.

o Changed the behavior of the read builtin to save any partial input received
in the specified variable when the read builtin times out. This also
results in variables specified as arguments to read to be set to the empty
string when there is no input available. When the read builtin times out,
it returns an exit status greater than 128.

o The shell now has the notion of a `compatibility level', controlled by
    new variables settable by `shopt'. Setting this variable currently
restores the bash-3.1 behavior when processing quoted strings on the rhs
of the `=~' operator to the `[[' command.

o The `ulimit' builtin now has new -b (socket buffer size) and -T (number
of threads) options.

o There is a new `compopt' builtin that allows completion functions to modify
completion options for existing completions or the completion currently
being executed.

o The `read' builtin has a new -i option which inserts text into the reply
buffer when using readline.

o A new `-E' option to the complete builtin allows control of the default
behavior for completion on an empty line.

o There is now limited support for completing command name words containing
globbing characters.

o The `help' builtin now has a new -d option, to display a short description,
and a -m option, to print help information in a man page-like format.

o There is a new `mapfile' builtin to populate an array with lines from a
given file.

o If a command is not found, the shell attempts to execute a shell function
named `command_not_found_handle', supplying the command words as the
function arguments.

o There is a new shell option: `globstar'.  When enabled, the globbing code
    treats `**' specially -- it matches all directories (and files within
them, when appropriate) recursively.

o There is a new shell option: `dirspell'. When enabled, the filename
completion code performs spelling correction on directory names during
completion.

o The `-t' option to the `read' builtin now supports fractional timeout
values.

o Brace expansion now allows zero-padding of expanded numeric values and
will add the proper number of zeroes to make sure all values contain the
same number of digits.

o There is a new bash-specific bindable readline function: `dabbrev-expand'.
It uses menu completion on a set of words taken from the history list.

o The command assigned to a key sequence with `bind -x' now sets two new
variables in the environment of the executed command:  READLINE_LINE_BUFFER
and READLINE_POINT. The command can change the current readline line
and cursor position by modifying READLINE_LINE_BUFFER and READLINE_POINT,
respectively.

o There is a new >>& redirection operator, which appends the standard output
and standard error to the named file.

o The parser now understands `|&' as a synonym for `2>&1 |', which redirects
the standard error for a command through a pipe.

o The new `;&' case statement action list terminator causes execution to
continue with the action associated with the next pattern in the
statement rather than terminating the command.

o The new `;;&' case statement action list terminator causes the shell to
test the next set of patterns after completing execution of the current
action, rather than terminating the command.

o The shell understands a new variable: PROMPT_DIRTRIM. When set to an
integer value greater than zero, prompt expansion of \w and \W will
retain only that number of trailing pathname components and replace
the intervening characters with `...'.

o There are new case-modifying word expansions: uppercase (^[^]) and
lowercase (,[,]). They can work on either the first character or
array element, or globally. They accept an optional shell pattern
that determines which characters to modify. There is an optionally-
configured feature to include capitalization operators.

o The shell provides associative array variables, with the appropriate
support to create, delete, assign values to, and expand them.

o The `declare' builtin now has new -l (convert value to lowercase upon
assignment) and -u (convert value to uppercase upon assignment) options.
There is an optionally-configurable -c option to capitalize a value at
assignment.

o There is a new `coproc' reserved word that specifies a coprocess: an
asynchronous command run with two pipes connected to the creating shell.
Coprocs can be named. The input and output file descriptors and the
PID of the coprocess are available to the calling shell in variables
with coproc-specific names.

o A value of 0 for the -t option to `read' now returns success if there is
input available to be read from the specified file descriptor.

o CDPATH and GLOBIGNORE are ignored when the shell is running in privileged
mode.

o New bindable readline functions shell-forward-word and shell-backward-word,
which move forward and backward words delimited by shell metacharacters
and honor shell quoting.

o New bindable readline functions shell-backward-kill-word and shell-kill-word
which kill words backward and forward, but use the same word boundaries
as shell-forward-word and shell-backward-word.

Bash-3.2 contained the following new features:

o Bash-3.2 now checks shell scripts for NUL characters rather than non-printing
characters when deciding whether or not a script is a binary file.

o Quoting the string argument to the [[ command's =~ (regexp) operator now
forces string matching, as with the other pattern-matching operators.

Bash-3.1 contained the following new features:

o Bash-3.1 may now be configured and built in a mode that enforces strict
POSIX compliance.

o The `+=' assignment operator, which appends to the value of a string or
array variable, has been implemented.

o It is now possible to ignore case when matching in contexts other than
filename generation using the new `nocasematch' shell option.

Bash-3.0 contained the following new features:

o Features to support the bash debugger have been implemented, and there
is a new `extdebug' option to turn the non-default options on

o HISTCONTROL is now a colon-separated list of options and has been
extended with a new `erasedups' option that will result in only one
copy of a command being kept in the history list

o Brace expansion has been extended with a new {x..y} form, producing
sequences of digits or characters

o Timestamps are now kept with history entries, with an option to save
and restore them from the history file; there is a new HISTTIMEFORMAT
variable describing how to display the timestamps when listing history
entries

o The `[[' command can now perform extended regular expression (egrep-like)
matching, with matched subexpressions placed in the BASH_REMATCH array
variable

o A new `pipefail' option causes a pipeline to return a failure status if
any command in it fails

o The `jobs', `kill', and `wait' builtins now accept job control notation
in their arguments even if job control is not enabled

o The `gettext' package and libintl have been integrated, and the shell
messages may be translated into other languages

Bash-2.05b introduced the following new features:

o support for multibyte characters has been added to both bash and readline

o the DEBUG trap is now run *before* simple commands, ((...)) commands,
[[...]] conditional commands, and for ((...)) loops

o the shell now performs arithmetic in the largest integer size the machine
supports (intmax_t)

o there is a new \D{...} prompt expansion; passes the `...' to strftime(3)
and inserts the result into the expanded prompt

o there is a new `here-string' redirection operator:  <<< word

o when displaying variables, function attributes and definitions are shown
separately, allowing them to be re-used as input (attempting to re-use
the old output would result in syntax errors).

o `read' has a new `-u fd' option to read from a specified file descriptor

o the bash debugger in examples/bashdb has been modified to work with the
new DEBUG trap semantics, the command set has been made more gdb-like,
and the changes to $LINENO make debugging functions work better

o the expansion of $LINENO inside a shell function is only relative to the
function start if the shell is interactive -- if the shell is running a
script, $LINENO expands to the line number in the script. This is as
POSIX-2001 requires

Bash-2.05a introduced the following new features:

o The `printf' builtin has undergone major work

o There is a new read-only `shopt' option: login_shell, which is set by
login shells and unset otherwise

o New `\A' prompt string escape sequence; expanding to time in 24-hour
HH:MM format

o New `-A group/-g' option to complete and compgen; goes group name
completion

o New [+-]O invocation option to set and unset `shopt' options at startup

o ksh-like `ERR' trap

o `for' loops now allow empty word lists after the `in' reserved word

o new `hard' and `soft' arguments for the `ulimit' builtin

o Readline can be configured to place the user at the same point on the line
when retrieving commands from the history list

o Readline can be configured to skip `hidden' files (filenames with a leading
  `.' on Unix) when performing completion

Bash-2.05 introduced the following new features:

o This version has once again reverted to using locales and strcoll(3) when
processing pattern matching bracket expressions, as POSIX requires.
o Added a new `--init-file' invocation argument as a synonym for `--rcfile',
per the new GNU coding standards.
o The /dev/tcp and /dev/udp redirections now accept service names as well as
port numbers.
o `complete' and `compgen' now take a `-o value' option, which controls some
of the aspects of that compspec. Valid values are:

        default - perform bash default completion if programmable
                  completion produces no matches
        dirnames - perform directory name completion if programmable
                   completion produces no matches
        filenames - tell readline that the compspec produces filenames,
                    so it can do things like append slashes to
                    directory names and suppress trailing spaces

o A new loadable builtin, realpath, which canonicalizes and expands symlinks
in pathname arguments.
o When `set' is called without options, it prints function definitions in a
  way that allows them to be reused as input.  This affects `declare' and
`declare -p' as well. This only happens when the shell is not in POSIX
mode, since POSIX.2 forbids this behavior.

Bash-2.04 introduced the following new features:

o Programmable word completion with the new `complete' and `compgen' builtins;
examples are provided in examples/complete/complete-examples
o `history' has a new `-d' option to delete a history entry
o `bind' has a new `-x' option to bind key sequences to shell commands
o The prompt expansion code has new `\j' and `\l' escape sequences
o The `no_empty_cmd_completion' shell option, if enabled, inhibits
  command completion when TAB is typed on an empty line
o `help' has a new `-s' option to print a usage synopsis
o New arithmetic operators: var++, var--, ++var, --var, expr1,expr2 (comma)
o New ksh93-style arithmetic for command:
	for ((expr1 ; expr2; expr3 )); do list; done
o `read' has new options: `-t', `-n', `-d', `-s'
o The redirection code handles several filenames specially:  /dev/fd/N,
/dev/stdin, /dev/stdout, /dev/stderr
o The redirection code now recognizes /dev/tcp/HOST/PORT and
/dev/udp/HOST/PORT and tries to open a TCP or UDP socket, respectively,
to the specified port on the specified host
o The ${!prefix*} expansion has been implemented
o A new FUNCNAME variable, which expands to the name of a currently-executing
function
o The GROUPS variable is no longer readonly
o A new shopt `xpg_echo' variable, to control the behavior of echo with
respect to backslash-escape sequences at runtime
o The NON_INTERACTIVE_LOGIN_SHELLS #define has returned

The version of Readline released with Bash-2.04, Readline-4.1, had several
new features as well:

o Parentheses matching is always compiled into readline, and controllable
with the new `blink-matching-paren' variable
o The history-search-forward and history-search-backward functions now leave
point at the end of the line when the search string is empty, like
reverse-search-history, and forward-search-history
o A new function for applications:  rl_on_new_line_with_prompt()
o New variables for applications:  rl_already_prompted, and rl_gnu_readline_p

Bash-2.03 had very few new features, in keeping with the convention
that odd-numbered releases provide mainly bug fixes. A number of new
features were added to Readline, mostly at the request of the Cygnus
folks.

A new shopt option, `restricted_shell', so that startup files can test
	whether or not the shell was started in restricted mode
Filename generation is now performed on the words between ( and ) in
	compound array assignments (this is really a bug fix)
OLDPWD is now auto-exported, as POSIX.2 requires
ENV and BASH_ENV are read-only variables in a restricted shell
Bash may now be linked against an already-installed Readline library,
	as long as the Readline library is version 4 or newer
All shells begun with the `--login' option will source the login shell
startup files, even if the shell is not interactive

There were lots of changes to the version of the Readline library released
along with Bash-2.03. For a complete list of the changes, read the file
CHANGES in the Bash-2.03 distribution.

Bash-2.02 contained the following new features:

a new version of malloc (based on the old GNU malloc code in previous
bash versions) that is more page-oriented, more conservative
with memory usage, does not `orphan' large blocks when they
	are freed, is usable on 64-bit machines, and has allocation
	checking turned on unconditionally
POSIX.2-style globbing character classes ([:alpha:], [:alnum:], etc.)
POSIX.2-style globbing equivalence classes
POSIX.2-style globbing collating symbols
the ksh [[...]] extended conditional command
the ksh egrep-style extended pattern matching operators
a new `printf' builtin
the ksh-like $(<filename) command substitution, which is equivalent to
$(cat filename)
new tilde prefixes that expand to directories from the directory stack
new `**' arithmetic operator to do exponentiation
case-insensitive globbing (filename expansion)
menu completion a la tcsh
`magic-space' history expansion function like tcsh
the readline inputrc `language' has a new file inclusion directive ($include)

Bash-2.01 contained only a few new features:

new `GROUPS' builtin array variable containing the user's group list
new bindable readline commands: history-and-alias-expand-line and
alias-expand-line

Bash-2.0 contained extensive changes and new features from bash-1.14.7.
Here's a short list:

new `time' reserved word to time pipelines, shell builtins, and
	shell functions
one-dimensional arrays with a new compound assignment statement,
        appropriate expansion constructs and modifications to some
	of the builtins (read, declare, etc.) to use them
new quoting syntaxes for ANSI-C string expansion and locale-specific
	string translation
new expansions to do substring extraction, pattern replacement, and
	indirect variable expansion
new builtins: `disown' and `shopt'
new variables: HISTIGNORE, SHELLOPTS, PIPESTATUS, DIRSTACK, GLOBIGNORE,
MACHTYPE, BASH_VERSINFO
special handling of many unused or redundant variables removed
(e.g., $notify, $glob_dot_filenames, $no_exit_on_failed_exec)
dynamic loading of new builtin commands; many loadable examples provided
new prompt expansions: \a, \e, \n, \H, \T, \@, \v, \V
history and aliases available in shell scripts
new readline variables: enable-keypad, mark-directories, input-meta,
visible-stats, disable-completion, comment-begin
new readline commands to manipulate the mark and operate on the region
new readline emacs mode commands and bindings for ksh-88 compatibility
updated and extended builtins
new DEBUG trap
expanded (and now documented) restricted shell mode

implementation stuff:
autoconf-based configuration
nearly all of the bugs reported since version 1.14 have been fixed
most builtins converted to use builtin `getopt' for consistency
most builtins use -p option to display output in a reusable form
(for consistency)
grammar tighter and smaller (66 reduce-reduce conflicts gone)
lots of code now smaller and faster
test suite greatly expanded

B2) Are there any user-visible incompatibilities between bash-4.3 and
previous bash versions?

There are a few incompatibilities between version 4.3 and previous
versions. They are detailed in the file COMPAT in the bash distribution.
That file is not meant to be all-encompassing; send mail to
bash-maintainers@gnu.org (or bug-bash@gnu.org if you would like
community discussion) if you find something that's not mentioned there.

Section C:  Differences from other Unix shells

C1) How does bash differ from sh, the Bourne shell?

This is a non-comprehensive list of features that differentiate bash
from the SVR4.2 shell. The bash manual page explains these more
completely.

Things bash has that sh does not:
long invocation options
[+-]O invocation option
-l invocation option
`!' reserved word to invert pipeline return value
`time' reserved word to time pipelines and shell builtins
the `function' reserved word
	the `select' compound command and reserved word
arithmetic for command: for ((expr1 ; expr2; expr3 )); do list; done
new $'...' and $"..." quoting
the $(...) form of command substitution
the $(<filename) form of command substitution, equivalent to
$(cat filename)
the ${#param} parameter value length operator
the ${!param} indirect parameter expansion operator
the ${!param*} prefix expansion operator
the ${param:offset[:length]} parameter substring operator
the ${param/pat[/string]} parameter pattern substitution operator
expansions to perform substring removal (${p%[%]w}, ${p#[#]w})
expansion of positional parameters beyond $9 with ${num}
variables: BASH, BASHPID, BASH_VERSION, BASH_VERSINFO, UID, EUID, REPLY,
TIMEFORMAT, PPID, PWD, OLDPWD, SHLVL, RANDOM, SECONDS,
LINENO, HISTCMD, HOSTTYPE, OSTYPE, MACHTYPE, HOSTNAME,
ENV, PS3, PS4, DIRSTACK, PIPESTATUS, HISTSIZE, HISTFILE,
HISTFILESIZE, HISTCONTROL, HISTIGNORE, GLOBIGNORE, GROUPS,
PROMPT_COMMAND, FCEDIT, FIGNORE, IGNOREEOF, INPUTRC,
SHELLOPTS, OPTERR, HOSTFILE, TMOUT, FUNCNAME, histchars,
auto_resume, PROMPT_DIRTRIM, BASHOPTS, BASH_XTRACEFD
DEBUG trap
ERR trap
variable arrays with new compound assignment syntax
redirections: <>, &>, >|, <<<, [n]<&word-, [n]>&word-, >>&
prompt string special char translation and variable expansion
auto-export of variables in initial environment
command search finds functions before builtins
bash return builtin will exit a file sourced with `.'
	builtins: cd -/-L/-P/-@, exec -l/-c/-a, echo -e/-E, hash -d/-l/-p/-t.
		  export -n/-f/-p/name=value, pwd -L/-P,
		  read -e/-p/-a/-t/-n/-d/-s/-u/-i/-N,
		  readonly -a/-f/name=value, trap -l, set +o,
		  set -b/-m/-o option/-h/-p/-B/-C/-H/-P,
		  unset -f/-n/-v, ulimit -i/-m/-p/-q/-u/-x,
		  type -a/-p/-t/-f/-P, suspend -f, kill -n,
		  test -o optname/s1 == s2/s1 < s2/s1 > s2/-nt/-ot/-ef/-O/-G/-S/-R
	bash reads ~/.bashrc for interactive shells, $ENV for non-interactive
	bash restricted shell mode is more extensive
	bash allows functions and variables with the same name
	brace expansion
	tilde expansion
	arithmetic expansion with $((...)) and `let' builtin
the `[[...]]' extended conditional command
	process substitution
	aliases and alias/unalias builtins
	local variables in functions and `local' builtin
readline and command-line editing with programmable completion
command history and history/fc builtins
csh-like history expansion
other new bash builtins: bind, command, compgen, complete, builtin,
declare/typeset, dirs, enable, fc, help,
history, logout, popd, pushd, disown, shopt,
printf, compopt, mapfile
exported functions
filename generation when using output redirection (command >a*)
POSIX.2-style globbing character classes
POSIX.2-style globbing equivalence classes
POSIX.2-style globbing collating symbols
egrep-like extended pattern matching operators
case-insensitive pattern matching and globbing
variable assignments preceding commands affect only that command,
even for builtins and functions
posix mode and strict posix conformance
redirection to /dev/fd/N, /dev/stdin, /dev/stdout, /dev/stderr,
/dev/tcp/host/port, /dev/udp/host/port
debugger support, including `caller' builtin and new variables
	RETURN trap
	the `+=' assignment operator
autocd shell option and behavior
command-not-found hook with command_not_found_handle shell function
globstar shell option and `**' globbing behavior
	|& synonym for `2>&1 |'
;& and ;;& case action list terminators
case-modifying word expansions and variable attributes
associative arrays
coprocesses using the `coproc' reserved word and variables
shell assignment of a file descriptor used in a redirection to a variable

Things sh has that bash does not:
uses variable SHACCT to do shell accounting
includes `stop' builtin (bash can use alias stop='kill -s STOP')
	`newgrp' builtin
turns on job control if called as `jsh'
	$TIMEOUT (like bash $TMOUT)
	`^' is a synonym for `|'
new SVR4.2 sh builtins: mldmode, priv

Implementation differences:
redirection to/from compound commands causes sh to create a subshell
bash does not allow unbalanced quotes; sh silently inserts them at EOF
bash does not mess with signal 11
sh sets (euid, egid) to (uid, gid) if -p not supplied and uid < 100
bash splits only the results of expansions on IFS, using POSIX.2
field splitting rules; sh splits all words on IFS
sh does not allow MAILCHECK to be unset (?)
sh does not allow traps on SIGALRM or SIGCHLD
bash allows multiple option arguments when invoked (e.g. -x -v);
sh allows only a single option argument (`sh -x -v' attempts
		to open a file named `-v', and, on SunOS 4.1.4, dumps core.
On Solaris 2.4 and earlier versions, sh goes into an infinite
loop.)
sh exits a script if any builtin fails; bash exits only if one of
the POSIX.2 `special' builtins fails

C2)  How does bash differ from the Korn shell, version ksh88?

Things bash has or uses that ksh88 does not:
long invocation options
[-+]O invocation option
-l invocation option
`!' reserved word
arithmetic for command: for ((expr1 ; expr2; expr3 )); do list; done
arithmetic in largest machine-supported size (intmax_t)
posix mode and posix conformance
command hashing
tilde expansion for assignment statements that look like $PATH
process substitution with named pipes if /dev/fd is not available
the ${!param} indirect parameter expansion operator
the ${!param*} prefix expansion operator
the ${param:offset[:length]} parameter substring operator
the ${param/pat[/string]} parameter pattern substitution operator
variables: BASH, BASH_VERSION, BASH_VERSINFO, BASHPID, UID, EUID, SHLVL,
       TIMEFORMAT, HISTCMD, HOSTTYPE, OSTYPE, MACHTYPE,
       HISTFILESIZE, HISTIGNORE, HISTCONTROL, PROMPT_COMMAND,
       IGNOREEOF, FIGNORE, INPUTRC, HOSTFILE, DIRSTACK,
       PIPESTATUS, HOSTNAME, OPTERR, SHELLOPTS, GLOBIGNORE,
       GROUPS, FUNCNAME, histchars, auto_resume, PROMPT_DIRTRIM
prompt expansion with backslash escapes and command substitution
redirection: &> (stdout and stderr), <<<, [n]<&word-, [n]>&word-, >>&
more extensive and extensible editing and programmable completion
builtins: bind, builtin, command, declare, dirs, echo -e/-E, enable,
      exec -l/-c/-a, fc -s, export -n/-f/-p, hash, help, history,
      jobs -x/-r/-s, kill -s/-n/-l, local, logout, popd, pushd,
      read -e/-p/-a/-t/-n/-d/-s/-N, readonly -a/-n/-f/-p,
      set -o braceexpand/-o histexpand/-o interactive-comments/
      -o notify/-o physical/-o posix/-o hashall/-o onecmd/
      -h/-B/-C/-b/-H/-P, set +o, suspend, trap -l, type,
      typeset -a/-F/-p, ulimit -i/-q/-u/-x, umask -S, alias -p,
      shopt, disown, printf, complete, compgen, compopt, mapfile
`!' csh-style history expansion
POSIX.2-style globbing character classes
POSIX.2-style globbing equivalence classes
POSIX.2-style globbing collating symbols
egrep-like extended pattern matching operators
case-insensitive pattern matching and globbing
`**' arithmetic operator to do exponentiation
redirection to /dev/fd/N, /dev/stdin, /dev/stdout, /dev/stderr
arrays of unlimited size
TMOUT is default timeout for `read' and `select'
	debugger support, including the `caller' builtin
RETURN trap
Timestamps in history entries
{x..y} brace expansion
The `+=' assignment operator
	autocd shell option and behavior
	command-not-found hook with command_not_found_handle shell function
	globstar shell option and `**' globbing behavior
|& synonym for `2>&1 |'
	;& and ;;& case action list terminators
	case-modifying word expansions and variable attributes
	associative arrays
	coprocesses using the `coproc' reserved word and variables
shell assignment of a file descriptor used in a redirection to a variable

Things ksh88 has or uses that bash does not:
tracked aliases (alias -t)
variables: ERRNO, FPATH, EDITOR, VISUAL
co-processes (bash uses different syntax)
weirdly-scoped functions
typeset +f to list all function names without definitions
text of command history kept in a file, not memory
builtins: alias -x, cd old new, newgrp, print,
read -p/-s/var?prompt, set -A/-o gmacs/
-o bgnice/-o markdirs/-o trackall/-o viraw/-s,
typeset -H/-L/-R/-Z/-A/-ft/-fu/-fx/-t, whence
using environment to pass attributes of exported variables
arithmetic evaluation done on arguments to some builtins
reads .profile from $PWD when invoked as login shell

Implementation differences:
ksh runs last command of a pipeline in parent shell context
bash has brace expansion by default (ksh88 compile-time option)
bash has fixed startup file for all interactive shells; ksh reads $ENV
bash has exported functions
bash command search finds functions before builtins
bash waits for all commands in pipeline to exit before returning status
emacs-mode editing has some slightly different key bindings

C3)  Which new features in ksh-93 are not in bash, and which are?

This list is current through ksh93v (10/08/2013)

New things in ksh-93 not in bash-4.3:
floating point arithmetic, variables, and constants
math library functions, including user-defined math functions
${!name[sub]} name of subscript for associative array
`.' is allowed in variable names to create a hierarchical namespace
more extensive compound assignment syntax
discipline functions
KEYBD trap
variables: .sh.edchar, .sh.edmode, .sh.edcol, .sh.edtext, .sh.version,
       .sh.name, .sh.subscript, .sh.value, .sh.match, HISTEDIT,
       .sh.sig, .sh.stats, .sh.siginfo, .sh.pwdfd, .sh.op_astbin,
       .sh.pool
backreferences in pattern matching (\N)
`&' operator in pattern lists for matching (match all instead of any)
exit statuses between 0 and 255
FPATH and PATH mixing
lexical scoping for local variables in `ksh' functions
	no scoping for local variables in `POSIX' functions
$''  \C[.collating-element.] escape sequence
-C/-I invocation options
print -f (bash uses printf) and rest of print builtin options
printf %(type)q, %#q
`fc' has been renamed to `hist'
`.' can execute shell functions
getopts -a
printf %B, %H, %P, %R, %Z modifiers, output base for %d, `=' flag
read -n/-N differ/-v/-S
set -o showme/-o multiline (bash default)
set -K
kill -Q/-q/-L
trap -a
`sleep' and `getconf' builtins (bash has loadable versions)
[[ -R name ]] (checks whether or not name is a nameref)
typeset -C/-S/-T/-X/-h/-s/-c/-M
experimental `type' definitions (a la typedef) using typeset
	array expansions ${array[sub1..sub2]} and ${!array[sub1..sub2]}
	associative array assignments using `;' as element separator
command substitution $(n<#) expands to current byte offset for fd N
new '${ ' form of command substitution, executed in current shell
new >;/<>;/<#pat/<##pat/<#/># redirections
brace expansion printf-like formats
CHLD trap triggered by SIGSTOP and SIGCONT
~{fd} expansion, which replaces fd with the corresponding path name
$"string" expanded when referenced rather than when first parsed
job "pools", which allow a collection of jobs to be managed as a unit

New things in ksh-93 present in bash-4.3:
associative arrays
[n]<&word- and [n]>&word- redirections (combination dup and close)
for (( expr1; expr2; expr3 )) ; do list; done - arithmetic for command
?:, ++, --, `expr1 , expr2' arithmetic operators
	expansions: ${!param}, ${param:offset[:len]}, ${param/pat[/str]},
		    ${!param*}
	compound array assignment
	negative subscripts for indexed array variables
	the `!' reserved word
loadable builtins -- but ksh uses `builtin' while bash uses `enable'
new $'...' and $"..." quoting
FIGNORE (but bash uses GLOBIGNORE), HISTCMD
brace expansion and set -B
changes to kill builtin
`command', `builtin', `disown' builtins
	echo -e
	exec -c/-a
	printf %T modifier
	read -A (bash uses read -a)
        read -t/-d
	trap -p
	`.' restores the positional parameters when it completes
set -o notify/-C
set -o pipefail
set -G (-o globstar) and **
POSIX.2 `test'
	umask -S
	unalias -a
	command and arithmetic substitution performed on PS1, PS4, and ENV
	command name completion, TAB displaying possible completions
	ENV processed only for interactive shells
	The `+=' assignment operator
the `;&' case statement "fallthrough" pattern list terminator
	csh-style history expansion and set -H
	negative offsets in ${param:offset:length}
	redirection operators preceded with {varname} to store fd number in varname
	DEBUG can force skipping following command
	[[ -v var ]] operator (checks whether or not var is set)
	typeset -n and `nameref' variables
process substitutions work without /dev/fd

Section D:  Why does bash do some things differently than other Unix shells?

D1) Why does bash run a different version of `command' than
    `which command' says it will?

On many systems, `which' is actually a csh script that assumes
you're running csh.  In tcsh, `which' and its cousin `where'
are builtins.  On other Unix systems, `which' is a perl script
that uses the PATH environment variable. Many Linux distributions
use GNU `which', which is a C program that can understand shell
aliases.

The csh script version reads the csh startup files from your
home directory and uses those to determine which `command' will
be invoked.  Since bash doesn't use any of those startup files,
there's a good chance that your bash environment differs from
your csh environment.  The bash `type' builtin does everything
`which' does, and will report correct results for the running
shell.  If you're really wedded to the name `which', try adding
the following function definition to your .bashrc:

	which()
	{
		builtin type "$@"
	}

If you're moving from tcsh and would like to bring `where' along
as well, use this function:

	where()
	{
		builtin type -a "$@"
	}

D2) Why doesn't bash treat brace expansions exactly like csh?

The only difference between bash and csh brace expansion is that
bash requires a brace expression to contain at least one unquoted
comma if it is to be expanded. Any brace-surrounded word not
containing an unquoted comma is left unchanged by the brace
expansion code. This affords the greatest degree of sh
compatibility.

Bash, ksh, zsh, and pd-ksh all implement brace expansion this way.

D3) Why doesn't bash have csh variable modifiers?

Posix has specified a more powerful, albeit somewhat more cryptic,
mechanism cribbed from ksh, and bash implements it.

${parameter%word}
Remove smallest suffix pattern. The WORD is expanded to produce
a pattern. It then expands to the value of PARAMETER, with the
smallest portion of the suffix matched by the pattern deleted.

        x=file.c
        echo ${x%.c}.o
        -->file.o

${parameter%%word}

        Remove largest suffix pattern.  The WORD is expanded to produce
        a pattern.  It then expands to the value of PARAMETER, with the
        largest portion of the suffix matched by the pattern deleted.

        x=posix/src/std
        echo ${x%%/*}
        -->posix

${parameter#word}
Remove smallest prefix pattern. The WORD is expanded to produce
a pattern. It then expands to the value of PARAMETER, with the
smallest portion of the prefix matched by the pattern deleted.

        x=$HOME/src/cmd
        echo ${x#$HOME}
        -->/src/cmd

${parameter##word}
Remove largest prefix pattern. The WORD is expanded to produce
a pattern. It then expands to the value of PARAMETER, with the
largest portion of the prefix matched by the pattern deleted.

        x=/one/two/three
        echo ${x##*/}
        -->three

Given
a=/a/b/c/d
b=b.xxx

	csh			bash		result
	---			----		------
	$a:h			${a%/*}		   /a/b/c
	$a:t			${a##*/}	   d
	$b:r			${b%.*}		   b
	$b:e			${b##*.}	   xxx

D4) How can I make my csh aliases work when I convert to bash?

Bash uses a different syntax to support aliases than csh does.
The details can be found in the documentation. We have provided
a shell script which does most of the work of conversion for you;
this script can be found in ./examples/misc/aliasconv.sh. Here is
how you use it:

Start csh in the normal way for you.  (e.g., `csh')

Pipe the output of `alias' through `aliasconv.sh', saving the
results into `bash_aliases':

	alias | bash aliasconv.sh >bash_aliases

Edit `bash_aliases', carefully reading through any created
functions. You will need to change the names of some csh specific
variables to the bash equivalents. The script converts $cwd to
$PWD, $term to $TERM, $home to $HOME, $user to $USER, and $prompt
to $PS1. You may also have to add quotes to avoid unwanted
expansion.

For example, the csh alias:

	alias cd 'cd \!*; echo $cwd'

is converted to the bash function:

	cd () { command cd "$@"; echo $PWD ; }

The only thing that needs to be done is to quote $PWD:

	cd () { command cd "$@"; echo "$PWD" ; }

Merge the edited file into your ~/.bashrc.

There is an additional, more ambitious, script in
examples/misc/cshtobash that attempts to convert your entire csh
environment to its bash equivalent. This script can be run as
simply `cshtobash' to convert your normal interactive
environment, or as `cshtobash ~/.login' to convert your login
environment.

D5) How can I pipe standard output and standard error from one command to
another, like csh does with `|&'?

Use
command 2>&1 | command2

The key is to remember that piping is performed before redirection, so
file descriptor 1 points to the pipe when it is duplicated onto file
descriptor 2.

D6) Now that I've converted from ksh to bash, are there equivalents to
ksh features like autoloaded functions and the `whence' command?

There are features in ksh-88 and ksh-93 that do not have direct bash
equivalents. Most, however, can be emulated with very little trouble.

ksh-88 feature Bash equivalent
--------------		---------------
compiled-in aliases set up aliases in .bashrc; some ksh aliases are
bash builtins (hash, history, type)
coprocesses named pipe pairs (one for read, one for write)
typeset +f declare -F
cd, print, whence function substitutes in examples/functions/kshenv
autoloaded functions examples/functions/autoload is the same as typeset -fu
read var?prompt read -p prompt var

ksh-93 feature Bash equivalent
--------------		---------------
sleep, getconf Bash has loadable versions in examples/loadables
${.sh.version}        $BASH_VERSION
print -f printf
hist alias hist=fc
$HISTEDIT        $FCEDIT

Section E:  How can I get bash to do certain things, and why does bash do
things the way it does?

E1) Why is the bash builtin `test' slightly different from /bin/test?

The specific example used here is [ ! x -o x ], which is false.

Bash's builtin `test' implements the Posix.2 spec, which can be
summarized as follows (the wording is due to David Korn):

Here is the set of rules for processing test arguments.

    0 Args: False
    1 Arg:  True iff argument is not null.
    2 Args: If first arg is !, True iff second argument is null.
	    If first argument is unary, then true if unary test is true
	    Otherwise error.
    3 Args: If second argument is a binary operator, do binary test of $1 $3
	    If first argument is !, negate two argument test of $2 $3
	    If first argument is `(' and third argument is `)', do the
	    one-argument test of the second argument.
	    Otherwise error.
    4 Args: If first argument is !, negate three argument test of $2 $3 $4.
	    Otherwise unspecified
    5 or more Args: unspecified.  (Historical shells would use their
    current algorithm).

The operators -a and -o are considered binary operators for the purpose
of the 3 Arg case.

As you can see, the test becomes (not (x or x)), which is false.

E2) Why does bash sometimes say `Broken pipe'?

If a sequence of commands appears in a pipeline, and one of the
reading commands finishes before the writer has finished, the
writer receives a SIGPIPE signal. Many other shells special-case
SIGPIPE as an exit status in the pipeline and do not report it.
For example, in:

      ps -aux | head

`head' can finish before `ps' writes all of its output, and ps
will try to write on a pipe without a reader. In that case, bash
will print `Broken pipe' to stderr when ps is killed by a
SIGPIPE.

As of bash-3.1, bash does not report SIGPIPE errors by default. You
can build a version of bash that will report such errors.

E3) When I have terminal escape sequences in my prompt, why does bash
wrap lines at the wrong column?

Readline, the line editing library that bash uses, does not know
that the terminal escape sequences do not take up space on the
screen. The redisplay code assumes, unless told otherwise, that
each character in the prompt is a `printable' character that
takes up one character position on the screen.

You can use the bash prompt expansion facility (see the PROMPTING
section in the manual page) to tell readline that sequences of
characters in the prompt strings take up no screen space.

Use the \[ escape to begin a sequence of non-printing characters,
and the \] escape to signal the end of such a sequence.

E4) If I pipe the output of a command into `read variable', why doesn't
the output show up in $variable when the read command finishes?

This has to do with the parent-child relationship between Unix
processes. It affects all commands run in pipelines, not just
simple calls to `read'.  For example, piping a command's output
into a `while' loop that repeatedly calls `read' will result in
the same behavior.

Each element of a pipeline, even a builtin or shell function,
runs in a separate process, a child of the shell running the
pipeline. A subprocess cannot affect its parent's environment.
When the `read' command sets the variable to the input, that
variable is set only in the subshell, not the parent shell. When
the subshell exits, the value of the variable is lost.

Many pipelines that end with `read variable' can be converted
into command substitutions, which will capture the output of
a specified command. The output can then be assigned to a
variable:

	grep ^gnu /usr/lib/news/active | wc -l | read ngroup

can be converted into

	ngroup=$(grep ^gnu /usr/lib/news/active | wc -l)

This does not, unfortunately, work to split the text among
multiple variables, as read does when given multiple variable
arguments. If you need to do this, you can either use the
command substitution above to read the output into a variable
and chop up the variable using the bash pattern removal
expansion operators or use some variant of the following
approach.

Say /usr/local/bin/ipaddr is the following shell script:

#! /bin/sh
host `hostname` | awk '/address/ {print $NF}'

Instead of using

	/usr/local/bin/ipaddr | read A B C D

to break the local machine's IP address into separate octets, use

	OIFS="$IFS"
	IFS=.
	set -- $(/usr/local/bin/ipaddr)
	IFS="$OIFS"
	A="$1" B="$2" C="$3" D="$4"

Beware, however, that this will change the shell's positional
parameters. If you need them, you should save them before doing
this.

This is the general approach -- in most cases you will not need to
set $IFS to a different value.

Some other user-supplied alternatives include:

read A B C D << HERE
$(IFS=.; echo $(/usr/local/bin/ipaddr))
HERE

and, where process substitution is available,

read A B C D < <(IFS=.; echo $(/usr/local/bin/ipaddr))

E5) I have a bunch of shell scripts that use backslash-escaped characters
in arguments to `echo'. Bash doesn't interpret these characters. Why
not, and how can I make it understand them?

This is the behavior of echo on most Unix System V machines.

The bash builtin `echo' is modeled after the 9th Edition
Research Unix version of `echo'. It does not interpret
backslash-escaped characters in its argument strings by default;
it requires the use of the -e option to enable the
interpretation. The System V echo provides no way to disable the
special characters; the bash echo has a -E option to disable
them.

There is a configuration option that will make bash behave like
the System V echo and interpret things like `\t' by default.  Run
configure with the --enable-xpg-echo-default option to turn this
on.  Be aware that this will cause some of the tests run when you
type `make tests' to fail.

There is a shell option, `xpg_echo', settable with `shopt', that will
change the behavior of echo at runtime. Enabling this option turns
on expansion of backslash-escape sequences.

E6) Why doesn't a while or for loop get suspended when I type ^Z?

This is a consequence of how job control works on Unix. The only
thing that can be suspended is the process group. This is a single
command or pipeline of commands that the shell forks and executes.

When you run a while or for loop, the only thing that the shell forks
and executes are any commands in the while loop test and commands in
the loop bodies. These, therefore, are the only things that can be
suspended when you type ^Z.

If you want to be able to stop the entire loop, you need to put it
within parentheses, which will force the loop into a subshell that
may be stopped (and subsequently restarted) as a single unit.

E7) What about empty for loops in Makefiles?

It's fairly common to see constructs like this in automatically-generated
Makefiles:

SUBDIRS = @SUBDIRS@

	...

subdirs-clean:
for d in ${SUBDIRS}; do \
( cd $$d && ${MAKE} ${MFLAGS} clean ) \
done

When SUBDIRS is empty, this results in a command like this being passed to
bash:

	for d in ; do
		( cd $d && ${MAKE} ${MFLAGS} clean )
	done

In versions of bash before bash-2.05a, this was a syntax error. If the
reserved word `in' was present, a word must follow it before the semicolon
or newline.  The language in the manual page referring to the list of words
being empty referred to the list after it is expanded.  These versions of
bash required that there be at least one word following the `in' when the
construct was parsed.

The idiomatic Makefile solution is something like:

SUBDIRS = @SUBDIRS@

subdirs-clean:
subdirs=$SUBDIRS ; for d in $$subdirs; do \
( cd $$d && ${MAKE} ${MFLAGS} clean ) \
done

The latest updated POSIX standard has changed this:  the word list
is no longer required. Bash versions 2.05a and later accept the
new syntax.

E8) Why does the arithmetic evaluation code complain about `08'?

The bash arithmetic evaluation code (used for `let', $(()), (()), and in
other places), interprets a leading `0' in numeric constants as denoting
an octal number, and a leading `0x' as denoting hexadecimal. This is
in accordance with the POSIX.2 spec, section 2.9.2.1, which states that
arithmetic constants should be handled as signed long integers as defined
by the ANSI/ISO C standard.

The POSIX.2 interpretation committee has confirmed this:

http://www.pasc.org/interps/unofficial/db/p1003.2/pasc-1003.2-173.html

E9) Why does the pattern matching expression [A-Z]* match files beginning
with every letter except `z'?

Bash-2.03, Bash-2.05 and later versions honor the current locale setting
when processing ranges within pattern matching bracket expressions ([A-Z]).
This is what POSIX.2 and SUSv3/XPG6 specify.

The behavior of the matcher in bash-2.05 and later versions depends on the
current LC_COLLATE setting. Setting this variable to `C' or `POSIX' will
result in the traditional behavior ([A-Z] matches all uppercase ASCII
characters). Many other locales, including the en_US locale (the default
on many US versions of Linux) collate the upper and lower case letters like
this:

	AaBb...Zz

which means that [A-Z] matches every letter except `z'. Others collate like

	aAbBcC...zZ

which means that [A-Z] matches every letter except `a'.

The portable way to specify upper case letters is [:upper:] instead of
A-Z; lower case may be specified as [:lower:] instead of a-z.

Look at the manual pages for setlocale(3), strcoll(3), and, if it is
present, locale(1). If you have locale(1), you can use it to find
your current locale information even if you do not have any of the
LC_ variables set.

My advice is to put

	export LC_COLLATE=C

into /etc/profile and inspect any shell scripts run from cron for
constructs like [A-Z]. This will prevent things like

	rm [A-Z]*

from removing every file in the current directory except those beginning
with `z' and still allow individual users to change the collation order.
Users may put the above command into their own profiles as well, of course.

E10) Why does `cd //' leave $PWD as `//'?

POSIX.2, in its description of `cd', says that *three* or more leading
slashes may be replaced with a single slash when canonicalizing the
current working directory.

This is, I presume, for historical compatibility. Certain versions of
Unix, and early network file systems, used paths of the form
//hostname/path to access `path' on server `hostname'.

E11) If I resize my xterm while another program is running, why doesn't bash
notice the change?

This is another issue that deals with job control.

The kernel maintains a notion of a current terminal process group. Members
of this process group (processes whose process group ID is equal to the
current terminal process group ID) receive terminal-generated signals like
SIGWINCH.  (For more details, see the JOB CONTROL section of the bash
man page.)

If a terminal is resized, the kernel sends SIGWINCH to each member of
the terminal's current process group (the `foreground' process group).

When bash is running with job control enabled, each pipeline (which may be
a single command) is run in its own process group, different from bash's
process group. This foreground process group receives the SIGWINCH; bash
does not. Bash has no way of knowing that the terminal has been resized.

There is a `checkwinsize' option, settable with the `shopt' builtin, that
will cause bash to check the window size and adjust its idea of the
terminal's dimensions each time a process stops or exits and returns control
of the terminal to bash. Enable it with `shopt -s checkwinsize'.

E12) Why don't negative offsets in substring expansion work like I expect?

When substring expansion of the form ${param:offset[:length} is used,
an `offset' that evaluates to a number less than zero counts back from
the end of the expanded value of $param.

When a negative `offset' begins with a minus sign, however, unexpected things
can happen. Consider

	a=12345678
	echo ${a:-4}

intending to print the last four characters of $a. The problem is that
${param:-word} already has a well-defined meaning: expand to word if the
expanded value of param is unset or null, and $param otherwise.

To use negative offsets that begin with a minus sign, separate the
minus sign and the colon with a space.

E13) Why does filename completion misbehave if a colon appears in the filename?

Filename completion (and word completion in general) may appear to behave
improperly if there is a colon in the word to be completed.

The colon is special to readline's word completion code:  it is one of the
characters that breaks words for the completer. Readline uses these characters
in sort of the same way that bash uses $IFS: they break or separate the words
the completion code hands to the application-specific or default word
completion functions. The original intent was to make it easy to edit
colon-separated lists (such as $PATH in bash) in various applications using
readline for input.

This is complicated by the fact that some versions of the popular
`bash-completion' programmable completion package have problems with the
default completion behavior in the presence of colons.

The current set of completion word break characters is available in bash as
the value of the COMP_WORDBREAKS variable. Removing `:' from that value is
enough to make the colon not special to completion:

COMP_WORDBREAKS=${COMP_WORDBREAKS//:}

You can also quote the colon with a backslash to achieve the same result
temporarily.

E14) Why does quoting the pattern argument to the regular expression matching
conditional operator (=~) cause regexp matching to stop working?

In versions of bash prior to bash-3.2, the effect of quoting the regular
expression argument to the [[ command's =~ operator was not specified.
The practical effect was that double-quoting the pattern argument required
backslashes to quote special pattern characters, which interfered with the
backslash processing performed by double-quoted word expansion and was
inconsistent with how the == shell pattern matching operator treated
quoted characters.

In bash-3.2, the shell was changed to internally quote characters in single-
and double-quoted string arguments to the =~ operator, which suppresses the
special meaning of the characters special to regular expression processing
(`.', `[', `\', `(', `), `*', `+', `?', `{', `|', `^', and `$') and forces
them to be matched literally. This is consistent with how the `==' pattern
matching operator treats quoted portions of its pattern argument.

Since the treatment of quoted string arguments was changed, several issues
have arisen, chief among them the problem of white space in pattern arguments
and the differing treatment of quoted strings between bash-3.1 and bash-3.2.
Both problems may be solved by using a shell variable to hold the pattern.
Since word splitting is not performed when expanding shell variables in all
operands of the [[ command, this allows users to quote patterns as they wish
when assigning the variable, then expand the values to a single string that
may contain whitespace. The first problem may be solved by using backslashes
or any other quoting mechanism to escape the white space in the patterns.

Bash-4.0 introduces the concept of a `compatibility level', controlled by
several options to the `shopt' builtin. If the `compat31' option is enabled,
bash reverts to the bash-3.1 behavior with respect to quoting the rhs of
the =~ operator.

E15) Tell me more about the shell compatibility level.

Bash-4.0 introduced the concept of a `shell compatibility level', specified
as a set of options to the shopt builtin (compat31, compat32, compat40 at
this writing). There is only one current compatibility level -- each
option is mutually exclusive. This list does not mention behavior that is
standard for a particular version (e.g., setting compat32 means that quoting
the rhs of the regexp matching operator quotes special regexp characters in
the word, which is default behavior in bash-3.2 and above).

compat31 set

- the < and > operators to the [[ command do not consider the current
  locale when comparing strings
- quoting the rhs of the regexp matching operator (=~) has no
  special effect

compat32 set

- the < and > operators to the [[ command do not consider the current
  locale when comparing strings

compat40 set

- the < and > operators to the [[ command do not consider the current
  locale when comparing strings
- interrupting a command list such as "a ; b ; c" causes the execution
  of the entire list to be aborted (in versions before bash-4.0,
  interrupting one command in a list caused the next to be executed)

compat41 set

- interrupting a command list such as "a ; b ; c" causes the execution
  of the entire list to be aborted (in versions before bash-4.1,
  interrupting one command in a list caused the next to be executed)
- when in posix mode, single quotes in the `word' portion of a
  double-quoted parameter expansion define a new quoting context and
  are treated specially

compat42 set

- the replacement string in double-quoted pattern substitution is not
  run through quote removal, as in previous versions

Section F:  Things to watch out for on certain Unix versions

F1) Why can't I use command line editing in my `cmdtool'?

The problem is `cmdtool' and bash fighting over the input.  When
scrolling is enabled in a cmdtool window, cmdtool puts the tty in
`raw mode' to permit command-line editing using the mouse for
applications that cannot do it themselves. As a result, bash and
cmdtool each try to read keyboard input immediately, with neither
getting enough of it to be useful.

This mode also causes cmdtool to not implement many of the
terminal functions and control sequences appearing in the
`sun-cmd' termcap entry. For a more complete explanation, see
that file examples/suncmd.termcap in the bash distribution.

`xterm' is a better choice, and gets along with bash much more
smoothly.

If you must use cmdtool, you can use the termcap description in
examples/suncmd.termcap. Set the TERMCAP variable to the terminal
description contained in that file, i.e.

TERMCAP='Mu|sun-cmd:am:bs:km:pt:li#34:co#80:cl=^L:ce=\E[K:cd=\E[J:rs=\E[s:'

Then export TERMCAP and start a new cmdtool window from that shell.
The bash command-line editing should behave better in the new
cmdtool. If this works, you can put the assignment to TERMCAP
in your bashrc file.

F2) I built bash on Solaris 2. Why do globbing expansions and filename
completion chop off the first few characters of each filename?

This is the consequence of building bash on SunOS 5 and linking
with the libraries in /usr/ucblib, but using the definitions
and structures from files in /usr/include.

The actual conflict is between the dirent structure in
/usr/include/dirent.h and the struct returned by the version of
`readdir' in libucb.a (a 4.3-BSD style `struct direct').

Make sure you've got /usr/ccs/bin ahead of /usr/ucb in your $PATH
when configuring and building bash. This will ensure that you
use /usr/ccs/bin/cc or acc instead of /usr/ucb/cc and that you
link with libc before libucb.

If you have installed the Sun C compiler, you may also need to
put /usr/ccs/bin and /opt/SUNWspro/bin into your $PATH before
/usr/ucb.

F3) Why does bash dump core after I interrupt username completion or
`~user' tilde expansion on a machine running NIS?

This is a famous and long-standing bug in the SunOS YP (sorry, NIS)
client library, which is part of libc.

The YP library code keeps static state -- a pointer into the data
returned from the server. When YP initializes itself (setpwent),
it looks at this pointer and calls free on it if it's non-null.
So far, so good.

If one of the YP functions is interrupted during getpwent (the
exact function is interpretwithsave()), and returns NULL, the
pointer is freed without being reset to NULL, and the function
returns. The next time getpwent is called, it sees that this
pointer is non-null, calls free, and the bash free() blows up
because it's being asked to free freed memory.

The traditional Unix mallocs allow memory to be freed multiple
times; that's probably why this has never been fixed. You can
run configure with the `--without-gnu-malloc' option to use
the C library malloc and avoid the problem.

F4) I'm running SVR4.2. Why is the line erased every time I type `@'?

The `@' character is the default `line kill' character in most
versions of System V, including SVR4.2. You can change this
character to whatever you want using `stty'. For example, to
change the line kill character to control-u, type

	stty kill ^U

where the `^' and `U' can be two separate characters.

F5) Why does bash report syntax errors when my C News scripts use a
redirection before a subshell command?

The actual command in question is something like

	< file ( command )

According to the grammar given in the POSIX.2 standard, this construct
is, in fact, a syntax error. Redirections may only precede `simple
commands'.  A subshell construct such as the above is one of the shell's
`compound commands'. A redirection may only follow a compound command.

This affects the mechanical transformation of commands that use `cat'
to pipe a file into a command (a favorite Useless-Use-Of-Cat topic on
comp.unix.shell). While most commands of the form

	cat file | command

can be converted to `< file command', shell control structures such as
loops and subshells require `command < file'.

The file CWRU/sh-redir-hack in the bash distribution is an
(unofficial) patch to parse.y that will modify the grammar to
support this construct. It will not apply with `patch'; you must
modify parse.y by hand. Note that if you apply this, you must
recompile with -DREDIRECTION_HACK. This introduces a large
number of reduce/reduce conflicts into the shell grammar.

F6) Why can't I use vi-mode editing on Red Hat Linux 6.1?

The short answer is that Red Hat screwed up.

The long answer is that they shipped an /etc/inputrc that only works
for emacs mode editing, and then screwed all the vi users by setting
INPUTRC to /etc/inputrc in /etc/profile.

The short fix is to do one of the following: remove or rename
/etc/inputrc, set INPUTRC=~/.inputrc in ~/.bashrc (or .bash_profile,
but make sure you export it if you do), remove the assignment to
INPUTRC from /etc/profile, add

        set keymap emacs

to the beginning of /etc/inputrc, or bracket the key bindings in
/etc/inputrc with these lines

	$if mode=emacs
		[...]
	$endif

F7) Why do bash-2.05a and bash-2.05b fail to compile `printf.def' on
HP/UX 11.x?

HP/UX's support for long double is imperfect at best.

GCC will support it without problems, but the HP C library functions
like strtold(3) and printf(3) don't actually work with long doubles.
HP implemented a `long_double' type as a 4-element array of 32-bit
ints, and that is what the library functions use.  The ANSI C
`long double' type is a 128-bit floating point scalar.

The easiest fix, until HP fixes things up, is to edit the generated
config.h and #undef the HAVE_LONG_DOUBLE line. After doing that,
the compilation should complete successfully.

Section G:  How can I get bash to do certain common things?

G1) How can I get bash to read and display eight-bit characters?

This is a process requiring several steps.

First, you must ensure that the `physical' data path is a full eight
bits.  For xterms, for example, the `vt100' resources `eightBitInput'
and `eightBitOutput' should be set to `true'.

Once you have set up an eight-bit path, you must tell the kernel and
tty driver to leave the eighth bit of characters alone when processing
keyboard input. Use `stty' to do this:

	stty cs8 -istrip -parenb

For old BSD-style systems, you can use

	stty pass8

You may also need

	stty even odd

Finally, you need to tell readline that you will be inputting and
displaying eight-bit characters. You use readline variables to do
this. These variables can be set in your .inputrc or using the bash
`bind' builtin.  Here's an example using `bind':

	bash$ bind 'set convert-meta off'
	bash$ bind 'set meta-flag on'
	bash$ bind 'set output-meta on'

The `set' commands between the single quotes may also be placed
in ~/.inputrc.

The script examples/scripts.noah/meta.bash encapsulates the bind
commands in a shell function.

G2) How do I write a function `x' to replace builtin command `x', but
still invoke the command from within the function?

This is why the `command' and `builtin' builtins exist. The
`command' builtin executes the command supplied as its first
argument, skipping over any function defined with that name.  The
`builtin' builtin executes the builtin command given as its first
argument directly.

For example, to write a function to replace `cd' that writes the
hostname and current directory to an xterm title bar, use
something like the following:

	cd()
	{
		builtin cd "$@" && xtitle "$HOST: $PWD"
	}

This could also be written using `command' instead of `builtin';
the version above is marginally more efficient.

G3) How can I find the value of a shell variable whose name is the value
of another shell variable?

Versions of Bash newer than Bash-2.0 support this directly. You can use

	${!var}

For example, the following sequence of commands will echo `z':

	var1=var2
	var2=z
	echo ${!var1}

For sh compatibility, use the `eval' builtin.  The important
thing to remember is that `eval' expands the arguments you give
it again, so you need to quote the parts of the arguments that
you want `eval' to act on.

For example, this expression prints the value of the last positional
parameter:

	eval echo \"\$\{$#\}\"

The expansion of the quoted portions of this expression will be
deferred until `eval' runs, while the `$#' will be expanded
before `eval' is executed. In versions of bash later than bash-2.0,

	echo ${!#}

does the same thing.

This is not the same thing as ksh93 `nameref' variables, though the syntax
is similar. Namerefs are available bash version 4.3, and work as in ksh93.

G4) How can I make the bash `time' reserved word print timing output that
looks like the output from my system's /usr/bin/time?

The bash command timing code looks for a variable `TIMEFORMAT' and
uses its value as a format string to decide how to display the
timing statistics.

The value of TIMEFORMAT is a string with `%' escapes expanded in a
fashion similar in spirit to printf(3). The manual page explains
the meanings of the escape sequences in the format string.

If TIMEFORMAT is not set, bash acts as if the following assignment had
been performed:

	TIMEFORMAT=$'\nreal\t%3lR\nuser\t%3lU\nsys\t%3lS'

The POSIX.2 default time format (used by `time -p command') is

	TIMEFORMAT=$'real %2R\nuser %2U\nsys %2S'

The BSD /usr/bin/time format can be emulated with:

	TIMEFORMAT=$'\t%1R real\t%1U user\t%1S sys'

The System V /usr/bin/time format can be emulated with:

	TIMEFORMAT=$'\nreal\t%1R\nuser\t%1U\nsys\t%1S'

The ksh format can be emulated with:

	TIMEFORMAT=$'\nreal\t%2lR\nuser\t%2lU\nsys\t%2lS'

G5) How do I get the current directory into my prompt?

Bash provides a number of backslash-escape sequences which are expanded
when the prompt string (PS1 or PS2) is displayed. The full list is in
the manual page.

The \w expansion gives the full pathname of the current directory, with
a tilde (`~') substituted for the current value of $HOME. The \W
expansion gives the basename of the current directory. To put the full
pathname of the current directory into the path without any tilde
substitution, use $PWD. Here are some examples:

	PS1='\w$ '	# current directory with tilde
	PS1='\W$ '	# basename of current directory
	PS1='$PWD$ '	# full pathname of current directory

The single quotes are important in the final example to prevent $PWD from
being expanded when the assignment to PS1 is performed.

G6) How can I rename "*.foo" to "*.bar"?

Use the pattern removal functionality described in D3. The following `for'
loop will do the trick:

	for f in *.foo; do
		mv $f ${f%foo}bar
	done

G7) How can I translate a filename from uppercase to lowercase?

The script examples/functions/lowercase, originally written by John DuBois,
will do the trick. The converse is left as an exercise.

G8) How can I write a filename expansion (globbing) pattern that will match
all files in the current directory except "." and ".."?

You must have set the `extglob' shell option using `shopt -s extglob' to use
this:

	echo .!(.|) *

A solution that works without extended globbing is given in the Unix Shell
FAQ, posted periodically to comp.unix.shell. It's a variant of

	echo .[!.]* ..?* *

(The ..?* catches files with names of three or more characters beginning
with `..')

Section H:  Where do I go from here?

H1) How do I report bugs in bash, and where should I look for fixes and
advice?

Use the `bashbug' script to report bugs. It is built and
installed at the same time as bash. It provides a standard
template for reporting a problem and automatically includes
information about your configuration and build environment.

`bashbug' sends its reports to bug-bash@gnu.org, which
is a large mailing list gatewayed to the usenet newsgroup gnu.bash.bug.

Bug fixes, answers to questions, and announcements of new releases
are all posted to gnu.bash.bug. Discussions concerning bash features
and problems also take place there.

To reach the bash maintainers directly, send mail to
bash-maintainers@gnu.org.

H2) What kind of bash documentation is there?

First, look in the doc directory in the bash distribution. It should
contain at least the following files:

bash.1 an extensive, thorough Unix-style manual page
builtins.1 a manual page covering just bash builtin commands
bashref.texi a reference manual in GNU tex`info format
bashref.info an info version of the reference manual
FAQ this file
article.ms text of an article written for The Linux Journal
readline.3 a man page describing readline

Postscript, HTML, and ASCII files created from the above source are
available in the documentation distribution.

There is additional documentation available for anonymous FTP from host
ftp.cwru.edu in the `pub/bash' directory.

Cameron Newham and Bill Rosenblatt have written a book on bash, published
by O'Reilly and Associates. The book is based on Bill Rosenblatt's Korn
Shell book. The title is ``Learning the Bash Shell'', and the ISBN number
of the third edition, published in March, 2005, is 0-596-00965-8. Look for
it in fine bookstores near you. This edition of the book has been updated
to cover bash-3.0.

The GNU Bash Reference Manual has been published as a printed book by
Network Theory Ltd (Paperback, ISBN: 0-9541617-7-7, Nov. 2006). It covers
bash-3.2 and is available from most online bookstores (see
http://www.network-theory.co.uk/bash/manual/ for details). The publisher
will donate $1 to the Free Software Foundation for each copy sold.

Arnold Robbins and Nelson Beebe have written ``Classic Shell Scripting'',
published by O'Reilly. The first edition, with ISBN number 0-596-00595-4,
was published in May, 2005.

Chris F. A. Johnson, a frequent contributor to comp.unix.shell and
gnu.bash.bug, has written ``Shell Scripting Recipes: A Problem-Solution
Approach,'' a new book on shell scripting, concentrating on features of
the POSIX standard helpful to shell script writers. The first edition from
Apress, with ISBN number 1-59059-471-1, was published in May, 2005.

H3) What's coming in future versions?

These are features I hope to include in a future version of bash.

Rocky Bernstein's bash debugger (support is included with bash-4.0)

H4) What's on the bash `wish list' for future versions?

These are features that may or may not appear in a future version of bash.

breaking some of the shell functionality into embeddable libraries
a module system like zsh's, using dynamic loading like builtins
a bash programmer's guide with a chapter on creating loadable builtins
a better loadable interface to perl with access to the shell builtins and
variables (contributions gratefully accepted)
ksh93-like `xx.yy' variables (including some of the .sh.* variables) and
associated discipline functions
Some of the new ksh93 pattern matching operators, like backreferencing

H5) When will the next release appear?

The next version will appear sometime in 2015. Never make predictions.

This document is Copyright 1995-2014 by Chester Ramey.

Permission is hereby granted, without written agreement and
without license or royalty fees, to use, copy, and distribute
this document for any purpose, provided that the above copyright
notice appears in all copies of this document and that the
contents of this document remain unaltered.
