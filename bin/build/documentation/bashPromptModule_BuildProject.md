## `bashPromptModule_BuildProject`

> Check which bin/build we are running and keep local to

### Usage

    bashPromptModule_BuildProject

Check which bin/build we are running and keep local to current project. Activates when we switch between projects.
- Re-sources `bin/build` so versions do not conflict.
- Runs hook `project-deactivate` in the old project (using that `bin/build` library)
- Runs the `project-activate` hook in the new project
- Displays the change in Zesk Build version

### Arguments

- none

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

