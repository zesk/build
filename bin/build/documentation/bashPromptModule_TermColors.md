### `bashPromptModule_TermColors`

> Terminal colors to match projects

#### Usage

    bashPromptModule_TermColors

Sets the console colors based on the project you are currently in.
Define your color configuration file (values of `bg=FFF` etc. one per line, comments allowed)

Will fill in missing bright or non-bright colors which are unspecified. (`blue` implies `br_blue` and so on)

Sets `decorateStyle` for valid styles

Support for iTerm2 is built-in and automatic

> Location: `bin/build/tools/prompt.sh`

#### Arguments

- none

#### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `term-colors` - When `bashPromptModule_TermColors` is enabled, will show colors and how they are applied

#### Examples

    bashPrompt --order 80 bashPromptModule_TermColors

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

- [`BUILD_TERM_COLORS_STATE` Terminal Color State]({rel}env/#application) – **String**. State to store state of current terminal color state

#### Requires

- [buildHome]({rel}tools/build.md#buildhome) - Prints the build home directory (usually same as the application ([source](https://github.com/zesk/build/blob/main/bin/build/tools/build.sh#L172))
- [statusMessage]({rel}tools/decorate.md#statusmessage) - Output a status message and display correctly on consoles with animation and in log files ([source](https://github.com/zesk/build/blob/main/bin/build/tools/colors.sh#L293))
- [buildEnvironmentGetDirectory]({rel}tools/build.md#buildenvironmentgetdirectory) - Load and print one or more environment settings which represents ([source](https://github.com/zesk/build/blob/main/bin/build/tools/build.sh#L607))
- [directoryRequire]({rel}tools/directory.md#directoryrequire) - Given a list of directories, ensure they exist and create ([source](https://github.com/zesk/build/blob/main/bin/build/tools/directory.sh#L194))
- [textSHA]({rel}tools/text.md#textsha) - SHA1 checksum of standard input ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L1034))
- --cachedecorate
- [buildDebugEnabled]({rel}tools/debug.md#builddebugenabled) - Is build debugging enabled? ([source](https://github.com/zesk/build/blob/main/bin/build/tools/debug.sh#L24))
- [iTerm2SetColors]({rel}tools/iterm2.md#iterm2setcolors) - Set terminal colors ([source](https://github.com/zesk/build/blob/main/bin/build/tools/iterm2.sh#L444))
- [consoleConfigureColorMode]({rel}tools/console.md#consoleconfigurecolormode) - Print the suggested color mode for the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/console.sh#L110))

#### See Also

- [consoleConfigureColorMode]({rel}tools/console.md#consoleconfigurecolormode) - Print the suggested color mode for the current environment ([source](https://github.com/zesk/build/blob/main/bin/build/tools/console.sh#L110))

