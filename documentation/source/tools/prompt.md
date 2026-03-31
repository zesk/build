# prompt Tools

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

The prompt supports a few things:

- `user@host ~/path` prefix
- Exit status of previous command is displayed
- Manage a queue of functions to run on each shell command

Tools to work with the shell prompt `PS1`

- `bashPromptModule_BuildProject` is a module for `bashPrompt` which deactivates and activates your Zesk Build project
  depending on your current
  directory
- `bashPromptModule_ApplicationPath` is a module for `bashPrompt` which displays the current application/path as a badge
  in iTerm
- `bashPromptModule_dotFilesWatcher` is a module for `bashPrompt` which monitors your home directory for files which
  start with `.` and lets you know when new ones have been added, and manages an approved list of files allowed.
- `consoleDefaultTitle` can be used as a module to set the current title

Examples:

    bashPrompt bashPromptModule_BuildProject consoleDefaultTitle
    bashPrompt --colors "$(bashPromptColorScheme forest)"

# Functions

{bashPrompt}

{bashPromptColorScheme}

{bashPromptColorsFormat}

{bashPromptMarkers}

{bashUserInput}

# Bash Prompt Modules

- {SEE:bashPromptModule_BuildProject}
- {SEE:bashPromptModule_ApplicationPath}
- {SEE:bashPromptModule_dotFilesWatcher}
- {SEE:bashPromptModule_TermColors}

To enable:

    bashPrompt bashPromptModule_BuildProject bashPromptModule_ApplicationPath

{bashPromptModule_BuildProject}

{bashPromptModule_ApplicationPath}

{bashPromptModule_dotFilesWatcher}

{bashPromptModule_TermColors}

## dotFilesWatcher Tools

Example during setup:

    dotFilesApproved bash > "$(dotFilesApprovedFile)"

And then in your bash prompt:

    bashPrompt bashPromptModule_dotFilesWatcher

Any new dot files which appear will then show a warning in your console.

{dotFilesApprovedFile}

{dotFilesApproved}

## reloadChanges Tools

{reloadChanges}

## Background Process Tools

{backgroundProcess}
