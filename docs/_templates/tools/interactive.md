# Interactive Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## File pipelines

{interactiveManager}

## User prompts

{confirmYesNo} {pause}

## Copy files

{copyFileWouldChange} {copyFile}

## Load bash files but get approval first

{interactiveBashSource}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "${args[@]}"; then
        __environment copyFile "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi
