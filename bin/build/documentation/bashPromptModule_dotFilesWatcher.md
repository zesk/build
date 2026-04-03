## `bashPromptModule_dotFilesWatcher`

> Watches your HOME directory for `.` files which are added

### Usage

    bashPromptModule_dotFilesWatcher

Watches your HOME directory for `.` files which are added and unknown to you.

### Arguments

- none

### Examples

    bashPrompt bashPromptModule_dotFilesWatcher

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Requires

sort buildEnvironmentGetDirectory touch returnEnvironment read basename inArray decorate printf confirmYesNo statusMessage grep rm

