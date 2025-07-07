# Application Development

This is a development tool and tracks the state of the "current" project you are working on.

The concept of the `Application Home` is the current project you are working on in your system. The value is stored in a
cache file and can be updated using `applicationHome` or the (default) aliases `g` and `G`.

A pattern used can be per-project:

    alias gFluxCapacitor='cd $HOME/projects/flux'
    alias GFluxCapacitor='gFluxCapacitor; G'

Which allows you to navigate between projects and change your current context.

{applicationHome}
{applicationHomeAliases}
