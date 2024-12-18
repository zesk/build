# prompt Tools

The prompt supports a few things:

- `user@host ~/path` prefix
- Exit status of previous command is displayed
- Manage a queue of functions to run on each shell command

Tools to work with the shell prompt `PS1`

- `bashPromptModule_binBuild` is a module for `bashPrompt` which sets the Zesk Build home depending on your current directory
- `bashPromptModule_ApplicationPath` is a module for `bashPrompt` which displays the current application/path as a badge in iTerm
- `consoleDefaultTitle` can be used as a module to set the current title

Examples:

    bashPrompt bashPromptModule_binBuild consoleDefaultTitle
    bashPrompt --colors "$(bashPromptColorScheme forest)"

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

## Functions

{bashPrompt}
{bashPromptColorScheme}

## Bash Prompt Modules

To enable:

    bashPrompt bashPromptModule_binBuild bashPromptModule_ApplicationPath

{bashPromptModule_binBuild}
{bashPromptModule_ApplicationPath}
