# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts


### `confirmYesNo` - Read user input and return 0 if the user says

Read user input and return 0 if the user says yes

#### Arguments

- `defaultValue` - Value to return if no value given by user

#### Exit codes

- `0` - Yes
- `1` - No

## Copy files 


#### Arguments

- `--map` - Flag. Optional. Map environment values into file before copying.
- `--escalate` - Flag. Optional. The file is a privilege escalation and needs visual confirmation.
- `source` - File. Required. Source path
- `destination` - File. Required. Destination path

#### Exit codes

- `0` - Something changed
- `1` - Nothing changed

#### Usage

    copyFileChangedQuiet source destination
    

#### Arguments

- `source` - Source file path
- `destination` - Destination file path

#### Exit codes

- `0` - Never fails

#### See Also

- [function copyFileChanged
](./docs/tools/interactive.md
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/interactive.sh#L43
)

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
