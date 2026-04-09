## `consoleToPlain`

> Strip ANSI console escape sequences from a file

### Usage

    consoleToPlain [ None. ]

Strip ANSI console escape sequences from a file

### Arguments

- None.

### Reads standard input

arbitrary text which may contain ANSI escape sequences for the terminal

### Writes to standard output

the same text with those ANSI escape sequences removed

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- None.

### Credits

Thanks to [commandlinefu tripleee
](https://stackoverflow.com/questions/6534556/how-to-remove-and-all-of-the-escape-sequences-in-a-file-using-linux-shell-sc
).

