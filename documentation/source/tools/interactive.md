# Interactive Functions

<!-- TEMPLATE header 2 -->
[⬅ Parent ](../index.md)
<hr />

## File pipelines

{interactiveManager}

## Interactive utilities

{loopExecute}

{interactiveCountdown}

{confirmYesNo}

{confirmMenu}

{pause}

{notify}

## Copy files

{fileCopyWouldChange} 

{fileCopy}

# Approve

{approvedSources}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if fileCopyWouldChange "${args[@]}"; then
        __environment fileCopy "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi
