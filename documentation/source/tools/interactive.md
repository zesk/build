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
{interactiveBashSource}
{notify}

## Copy files

{copyFileWouldChange} {copyFile}

## Examples

Example:

    args=(--map configure/sshd_config /etc/ssh/sshd_config)
    if copyFileWouldChange "${args[@]}"; then
        __environment copyFile "${args[@]}" || return $?
        __environment service ssh restart || return $?
    fi
