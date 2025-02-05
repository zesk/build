# (iTerm2 Tools)[https://iterm2.com/]

### `isiTerm2` - Is the current console iTerm2?

Is the current console iTerm2?
Fails if LC_TERMINAL is `iTerm2`
Fails also if TERM is `screen`

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `iTerm2Init` - Add iTerm2 support to console

Add iTerm2 support to console

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

LC_TERMINAL
TERM
### `iTerm2Badge` - Set the badge for the iTerm2 console

Set the badge for the iTerm2 console

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.
- `message ...` - Any message to display as the badge

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

LC_TERMINAL
### `iTerm2Attention` - Attract the operator

Attract the operator

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

--ignore |- ` -i` - Flag. Optional. If the current terminal is not iTerm2, then exit status 0 and do nothing.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `iTerm2Aliases` - Installs iTerm2 aliases which are:

Installs iTerm2 aliases which are:

- `it2check` - Check compatibility of these scripts (non-zero exit means non-compatible)
- `imgcat` - Take an image file and output it to the console
- `imgls` - List a directory and show thumbnails (in the console)
- `it2attention` - Get attention from the operator
- `it2getvar` - Get a variable value
- `it2dl` - Download a file to the operator system's configured download folder
- `it2ul` - Upload a file from the operator system to the remote
- `it2copy` - Copy to clipboard from file or stdin
- `it2setcolor` - Set console colors interactively
- `it2setkeylabel` - Set key labels interactively
- `it2universion` - Set, push, or pop Unicode version

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `iTerm2PromptSupport` - Add support for iTerm2 to bashPrompt

Add support for iTerm2 to bashPrompt
If you are wondering what this does - it delimits the prompt, your command, and the output in the console so iTerm2 can be nice and let you
select it.
It also reports the host, user and current directory back to iTerm2 on every prompt command.

- Location: `bin/build/tools/iterm2.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

__ITERM2_HOST
__ITERM2_HOST_TIME
