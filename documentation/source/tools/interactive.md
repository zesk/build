# Interactive Functions

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Top ](../index.md)
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
        catchEnvironment "$handler" fileCopy "${args[@]}" || return $?
        catchEnvironment "$handler" service ssh restart || return $?
    fi
