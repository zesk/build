### `bashPromptModule_dotFilesWatcher`

> Monitor home directory for new `.` files

#### Usage

    bashPromptModule_dotFilesWatcher

Watches your HOME directory for `.` files which are added and unknown to you.

> Location: `bin/build/tools/prompt-modules.sh`

#### Arguments

- none

#### Examples

    bashPrompt bashPromptModule_dotFilesWatcher

#### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Requires

- [`sort`]({rel}guide/command.md#sort)
- {SEE:buildEnvironmentGetDirectory}
- [`touch`]({rel}guide/command.md#touch)
- {SEE:returnEnvironment}
- [`read`]({rel}guide/builtin.md#read)
- [`basename`]({rel}guide/command.md#basename)
- {SEE:inArray}
- {SEE:decorate}
- [`printf`]({rel}guide/builtin.md#printf)
- {SEE:confirmYesNo}
- {SEE:statusMessage}
- [`grep`]({rel}guide/command.md#grep)
- [`rm`]({rel}guide/command.md#rm)

