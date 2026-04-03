## `confirmMenu`

> Ask the user for a menu of options

### Usage

    confirmMenu --choice choiceCharacter [ --default default ] --result resultFile [ --attempts attemptCount ] [ --timeout timeoutSeconds ] [ --prompt promptString ] [ message ]

Ask the user for a menu of options

### Arguments

- `--choice choiceCharacter` - String. Required. Character to accept.
- `--default default` - String. Optional. Character to choose when there is a timeout or other failure.
- `--result resultFile` - File. Required. File to write the result to.
- `--attempts attemptCount` - PositiveInteger. Optional. Number of attempts to try and get valid unput from the user.
- `--timeout timeoutSeconds` - PositiveInteger. Optional. Number of seconds to wait for user input before stopping.
- `--prompt promptString` - String. Optional. String to suffix the prompt with (usually tells the user what to do)
- `message` - String. Optional. Display this message as the confirmation menu.

### Return codes

- `interrupt` - Attempts exceeded
- `timeout` - Timeout

