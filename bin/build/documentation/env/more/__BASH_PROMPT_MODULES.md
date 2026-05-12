## `__BASH_PROMPT_MODULES`

> **__BASH_PROMPT_MODULES** &mdash; List of functions to run each prompt command
> > **Type**: *Array:Callable* • **Category**: *Bash Prompt*

List of modules to run each prompt command.

Manage with `bashPrompt functionName` to add, `bashPrompt --remove functionName` to remove.

Make your functions *really* fast otherwise the shell becomes sluggish. Also try:

    BUILD_DEBUG=bashPrompt

To report on each command and timing.

An automatic reporting occurs when commands exceed 0.3s.

### See Also

- ## `bashPrompt`

