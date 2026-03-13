# Interactive Functions

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## File pipelines

{interactiveManager}

## Interactive utilities

{executeLoop}

{interactiveCountdown}

{confirmYesNo}

{confirmMenu}

{pause}

{notify}

{interactiveOccasionally}

## Copy files

{fileCopyWouldChange} 

{fileCopy}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if fileCopyWouldChange "${args[@]}"; then
        catchEnvironment "$handler" fileCopy "${args[@]}" || return $?
        catchEnvironment "$handler" service ssh restart || return $?
    fi
