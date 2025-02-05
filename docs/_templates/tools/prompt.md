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

{bashPrompt} {bashPromptColorScheme}
{bashPromptMarkers}
{bashPromptUser}

## Bash Prompt Modules

- [`bashPromptModule_binBuild`](#bashPromptModule_binBuild)
- [`bashPromptModule_ApplicationPath`](#bashPromptModule_ApplicationPath)
- [`bashPromptModule_dotFilesWatcher`](#bashPromptModule_dotFilesWatcher)

To enable:

    bashPrompt bashPromptModule_binBuild bashPromptModule_ApplicationPath

{bashPromptModule_binBuild} {bashPromptModule_ApplicationPath} {bashPromptModule_dotFilesWatcher}

## dotFilesWatcher Tools

Example during setup:

   dotFilesApproved bash > "$(dotFilesApprovedFile)"

And then in your bash prompt:

   bashPrompt bashPromptModule_dotFilesWatcher

Any new dot files which appear will then show a warning in your console.

{dotFilesApprovedFile}
{dotFilesApproved}
