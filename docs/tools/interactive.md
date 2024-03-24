# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts


### `confirmYesNo` - Read user input and return 0 if the user says

Read user input and return 0 if the user says yes

#### Usage

    confirmYesNo [ defaultValue ]
    

#### Arguments



#### Exit codes

- `0` - Yes
- `1` - No

## Copy files 


#### Usage

    copyFileWouldChange [ --map ] source destination
    

#### Arguments



#### Exit codes

- `0` - Something would change
- `1` - Nothing would change

#### Usage

    copyFile [ --map ] [ --escalate ] source destination
    

#### Arguments



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
