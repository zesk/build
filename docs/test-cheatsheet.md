# test Cheat Sheet

An blank EXPRESSION is false.

Expression combinations:

- `( EXPRESSION )` - `EXPRESSION` grouping (is true)
- `! EXPRESSION` - Invert `EXPRESSION`
- `EXPRESSION1 -a EXPRESSION2` - both `EXPRESSION1` and `EXPRESSION2` are true
- `EXPRESSION1 -o EXPRESSION2` - either EXPRESSION1 or `EXPRESSION2` is true

# Strings

- `-n STRING` - the length of `STRING` is nonzero
- `-z STRING` - the length of `STRING` is zero
- `STRING1 = STRING2` - the strings are equal
- `STRING1 != STRING2` - the strings are not equal

# Integers

- `INTEGER1 -eq INTEGER2` - `INTEGER1` is equal to `INTEGER2`
- `INTEGER1 -ge INTEGER2` - `INTEGER1` is greater than or equal to `INTEGER2`
- `INTEGER1 -gt INTEGER2` - `INTEGER1` is greater than `INTEGER2`
- `INTEGER1 -le INTEGER2` - `INTEGER1` is less than or equal to `INTEGER2`
- `INTEGER1 -lt INTEGER2` - `INTEGER1` is less than `INTEGER2`
- `INTEGER1 -ne INTEGER2` - `INTEGER1` is not equal to `INTEGER2`

# Files

- `FILE1 -ef FILE2` - `FILE1` and `FILE2` have the same device and inode numbers
- `FILE1 -nt FILE2` - `FILE1` is newer (modification date) than `FILE2`
- `FILE1 -ot FILE2` - `FILE1` is older than `FILE2`

# File types

- `-e FILE` - FILE exists
- `-b FILE` - FILE exists and is block special
- `-c FILE` - FILE exists and is character special
- `-d FILE` - FILE exists and is a directory
- `-f FILE` - FILE exists and is a regular file
- `-p FILE` - FILE exists and is a named pipe
- `-L FILE` - FILE exists and is a symbolic link (same as `-h`)
- `-h FILE` - FILE exists and is a symbolic link (same as `-L`)
- `-S FILE` - FILE exists and is a socket

# File bits

- `-k FILE` - FILE exists and has its sticky bit set
- `-g FILE` - FILE exists and is set-group-ID
- `-u FILE` - FILE exists and its set-user-ID bit is set

# File permissions

- `-G FILE` - FILE exists and is owned by the effective group ID
- `-O FILE` - FILE exists and is owned by the effective user ID
- `-r FILE` - FILE exists and the user has read access
- `-w FILE` - FILE exists and the user has write access
- `-x FILE` - FILE exists and the user has execute (or search) access

# File is not empty

- `-s FILE` - `FILE` exists and has a size greater than zero
- `-N FILE` - `FILE` exists and has been modified since it was last read

# Test if a file descriptor is a terminal

- `-t FD` - file descriptor `FD` is opened on a terminal

Except for `-h` and `-L`, all `FILE`-related tests dereference symbolic links.

Beware that parentheses need to be escaped (e.g., by backslashes) for shells. 

Binary `-a` and `-o` are ambiguous. Use `test EXPR1 && test EXPR2` or `test EXPR1 || test EXPR2` instead.

[Source](https://github.com/zesk/build/docs/test-cheatsheet.md)
