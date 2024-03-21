# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts


### `confirmYesNo` - Read user input and return 0 if the user says

Read user input and return 0 if the user says yes

#### Arguments

- `defaultValue` - Value to return if no value given by user

#### Exit codes

- `0` - Yes
- `1` - No

## Copy files 


#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Something would change
- `1` - Nothing would change

#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `--escalate` - Flag. Optional. The file is a privilege escalation and needs visual confirmation.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Success
- `1` - Failed

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "${args[@]}"; then
        __environment copyFile "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
