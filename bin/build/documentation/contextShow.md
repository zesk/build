### `contextShow`

> Show the current editor being used as a text string

#### Usage

    contextShow

Show the current editor being used as a text string

> Location: `bin/build/tools/vendor.sh`

#### Arguments

- none

#### Return codes

- `1` - If no editor or running program can be determined

#### Environment

- [`EDITOR` Editor Command]({rel}env/#bash) – **Callable**. Binary for editing files - Used as a default editor (first)
- [`VISUAL` File Preview]({rel}env/#bash) – **Executable**. Binary for viewing files - Used as another default editor (last)

