# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts

{confirmYesNo}

## Copy files 

{copyFileWouldChange}
{copyFile}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "${args[@]}"; then
        __environment copyFile "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi


[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
