# Interactive Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

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
