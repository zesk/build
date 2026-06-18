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
- [buildEnvironmentGetDirectory]({rel}tools/build.md#buildenvironmentgetdirectory) - Load and print one or more environment settings which represents ([source](https://github.com/zesk/build/blob/main/bin/build/tools/build.sh#L606))
- [`touch`]({rel}guide/command.md#touch)
- [returnEnvironment]({rel}tools/sugar-core.md#returnenvironment) - Return \`environment\` error code. Outputs \`message ...\` to \`stderr\`. ([source](https://github.com/zesk/build/blob/main/bin/build/tools/_sugar.sh#L265))
- [`read`]({rel}guide/builtin.md#read)
- [`basename`]({rel}guide/command.md#basename)
- [inArray]({rel}tools/text.md#inarray) - Check if an element exists in an array ([source](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh#L393))
- [decorate]({rel}tools/decorate.md#decorate) - Singular decoration function ([source](https://github.com/zesk/build/blob/main/bin/build/tools/decorate/core.sh#L89))
- [`printf`]({rel}guide/builtin.md#printf)
- [confirmYesNo]({rel}tools/interactive.md#confirmyesno) - Read user input and return success on yes ([source](https://github.com/zesk/build/blob/main/bin/build/tools/interactive.sh#L162))
- [statusMessage]({rel}tools/decorate.md#statusmessage) - Output a status message and display correctly on consoles with animation and in log files ([source](https://github.com/zesk/build/blob/main/bin/build/tools/colors.sh#L316))
- [`grep`]({rel}guide/command.md#grep)
- [`rm`]({rel}guide/command.md#rm)

