# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts

{confirmYesNo}

## Copy files

{fileCopyWouldChange} {fileCopy}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if fileCopyWouldChange "${args[@]}"; then
        __environment fileCopy "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
