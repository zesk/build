# Interactive Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## User prompts




## Copy files 




## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "$"; then
        __environment copyFile "$" || return $?
        __environment service ssh restart || return $?
    fi
