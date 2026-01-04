#!/usr/bin/env bash
#
# readline.sh
#
# Copyright &copy; 2026 Market Acumen, Inc.

# Add configuration to `~/.inputrc` for a key binding
# DOC TEMPLATE: --help 1
# Argument: --help - Optional. Flag. Display this help.
# Argument: keyStroke - Required. String.
# Argument: action - Required. String.
# Example: readlineConfigurationAdd "\ep" history-search-backward
readlineConfigurationAdd() {
  local handler="_${FUNCNAME[0]}"
  [ "${1-}" != "--help" ] || __help "$handler" "$@" || return 0

  local target=".input""rc" keyStroke="${1-}" action="${2-}" pattern
  local home

  home="$(catchReturn "$handler" buildEnvironmentGet HOME)" || return $?
  target="$home/$target"
  [ -f "$target" ] || catchEnvironment "$handler" touch "$target" || return $?
  pattern="^$(quoteGrepPattern "\"$keyStroke\":")"
  if grep -q -e "$pattern" <"$target"; then
    grep -v "$pattern" >"$target.new" <"$target"
    catchEnvironment "$handler" mv -f "$target.new" "$target" || returnClean $? "$target.new" || return $?
  fi
  catchEnvironment "$handler" printf "\"%s\": %s\n" "$keyStroke" "$action" >>"$target" || return $?
}
_readlineConfigurationAdd() {
  # __IDENTICAL__ usageDocument 1
  usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
}

#   Readline Initialization
#       Readline is customized by putting commands in an initialization file (the inputrc file).  The name of this file is taken from the value of the INPUTRC variable.  If that variable is
#       unset, the default is ~/.inputrc.  When a program which uses the readline library starts up, the initialization file is read, and the key bindings and variables are set.  There are
#       only a few basic constructs allowed in the readline initialization file.  Blank lines are ignored.  Lines beginning with a # are comments.  Lines beginning with a $ indicate
#       conditional constructs.  Other lines denote key bindings and variable settings.
#
#       The default key-bindings may be changed with an inputrc file.  Other programs that use this library may add their own commands and bindings.
#
#       For example, placing
#
#              M-Control-u: universal-argument
#       or
#              C-Meta-u: universal-argument
#       into the inputrc would make M-C-u execute the readline command universal-argument.
#
#       The following symbolic character names are recognized: RUBOUT, DEL, ESC, LFD, NEWLINE, RET, RETURN, SPC, SPACE, and TAB.
#
#       In addition to command names, readline allows keys to be bound to a string that is inserted when the key is pressed (a macro).
#

#   Readline Key Bindings
#       The syntax for controlling key bindings in the inputrc file is simple.  All that is required is the name of the command or the text of a macro and a key sequence to which it should
#       be bound. The name may be specified in one of two ways: as a symbolic key name, possibly with Meta- or Control- prefixes, or as a key sequence.
#
#       When using the form keyname:function-name or macro, keyname is the name of a key spelled out in English.  For example:
#
#              Control-u: universal-argument
#              Meta-Rubout: backward-kill-word
#              Control-o: "> output"
#
#       In the above example, C-u is bound to the function universal-argument, M-DEL is bound to the function backward-kill-word, and C-o is bound to run the macro expressed on the right
#       hand side (that is, to insert the text ``> output'' into the line).
#
#       In the second form, "keyseq":function-name or macro, keyseq differs from keyname above in that strings denoting an entire key sequence may be specified by placing the sequence
#       within double quotes.  Some GNU Emacs style key escapes can be used, as in the following example, but the symbolic character names are not recognized.
#
#              "\C-u": universal-argument
#              "\C-x\C-r": re-read-init-file
#              "\e[11~": "Function Key 1"
#
#       In this example, C-u is again bound to the function universal-argument.  C-x C-r is bound to the function re-read-init-file, and ESC [ 1 1 ~ is bound to insert the text ``Function
#       Key 1''.
#
#       The full set of GNU Emacs style escape sequences is
#              \C-    control prefix
#              \M-    meta prefix
#              \e     an escape character
#              \\     backslash
#              \"     literal "
#              \'     literal '
#
#       In addition to the GNU Emacs style escape sequences, a second set of backslash escapes is available:
#              \a     alert (bell)
#              \b     backspace
#              \d     delete
#              \f     form feed
#              \n     newline
#              \r     carriage return
#              \t     horizontal tab
#              \v     vertical tab
#              \nnn   the eight-bit character whose value is the octal value nnn (one to three digits)
#              \xHH   the eight-bit character whose value is the hexadecimal value HH (one or two hex digits)
#
#       When entering the text of a macro, single or double quotes must be used to indicate a macro definition.  Unquoted text is assumed to be a function name.  In the macro body, the
#       backslash escapes described above are expanded.  Backslash will quote any other character in the macro text, including " and '.
#
#       Bash allows the current readline key bindings to be displayed or modified with the bind builtin command.  The editing mode may be switched during interactive use by using the -o
#       option to the set builtin command (see SHELL BUILTIN COMMANDS below).
#

# set mark-directories On

# BSD-read
#
#       read [-ers] [-u fd] [-t timeout] [-a aname] [-p prompt] [-n nchars] [-d delim] [name ...]
#              One line is read from the standard input, or from the file descriptor fd supplied as an argument to the -u option, and the first word is assigned to the first name, the
#              second word to the second name, and so on, with leftover words and their intervening separators assigned to the last name.  If there are fewer words read from the input
#              stream than names, the remaining names are assigned empty values.  The characters in IFS are used to split the line into words.  The backslash character (\) may be used to
#              remove any special meaning for the next character read and for line continuation.  Options, if supplied, have the following meanings:
#              -a aname
#                     The words are assigned to sequential indices of the array variable aname, starting at 0.  aname is unset before any new values are assigned.  Other name arguments are
#                     ignored.
#              -d delim
#                     The first character of delim is used to terminate the input line, rather than newline.
#              -e     If the standard input is coming from a terminal, readline (see READLINE above) is used to obtain the line.
#              -n nchars
#                     read returns after reading nchars characters rather than waiting for a complete line of input.
#              -p prompt
#                     Display prompt on standard error, without a trailing newline, before attempting to read any input.  The prompt is displayed only if input is coming from a terminal.
#              -r     Backslash does not act as an escape character.  The backslash is considered to be part of the line.  In particular, a backslash-newline pair may not be used as a line
#                     continuation.
#              -s     Silent mode.  If input is coming from a terminal, characters are not echoed.
#              -t timeout
#                     Cause read to time out and return failure if a complete line of input is not read within timeout seconds.  This option has no effect if read is not reading input from
#                     the terminal or a pipe.
#              -u fd  Read input from file descriptor fd.
#
#              If no names are supplied, the line read is assigned to the variable REPLY.  The return code is zero, unless end-of-file is encountered, read times out, or an invalid file
#              descriptor is supplied as the argument to -u.
#
