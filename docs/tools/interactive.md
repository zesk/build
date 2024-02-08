# Interactive Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)

## User prompts


### `yesNo` - Parses text and determines if it\'s a yes.

Parses text and determines if it\'s a yes.

#### Usage

    yesNo text
    

#### Exit codes

- `0` - Yes
- `1` - No
- `2` - Neither

#### See Also

- [function lowercase
](./docs/tools/text.md
) - [Convert text to lowercase
](https://github.com/zesk/build/blob/main/bin/build/tools/text.sh
#L249
)
{SEE:}

### `confirmYesNo` - Read user input and return 0 if the user says

Read user input and return 0 if the user says yes

#### Arguments

- `defaultValue` - Value to return if no value given by user

#### Exit codes

- `0` - Yes
- `1` - No

## Copy files 

Escalation means copying between users. Escalation copy shows differences and prompts user.


#### Usage

    copyFileChanged source destination
    

#### Arguments

- `source` - Source path
- `destination` - Destination path

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
) - [{summary}](https://github.com/zesk/build/blob/main/bin/build/tools/interactive.sh
#L161
)
{SEE:}

### `mapCopyFileChanged` - Map a file using environment variables before copying, return 0

Map a file using environment variables before copying, return 0 if something changed

#### Usage

    mapCopyFileChanged source destination
    

#### Arguments

- `from` - Source path
- `to` - Destination path

#### Exit codes

- `0` - Something changed
- `1` - Nothing changed

#### Usage

    escalatedCopyFileChanged source destination
    

#### Arguments

- `source` - Source file path
- `destination` - Destination file path

#### Exit codes

- `0` - Something changed
- `1` - Nothing changed

### `escalatedMapCopyFileChanged` - Used when copying a file from a non-privileged user to

Used when copying a file from a non-privileged user to a privileged location (root) or anything which allows for user
escalation privileges. Maps the file using local environment.

#### Usage

    escalatedCopyFileChanged source destination
    

#### Arguments

- `source` - Source file path
- `destination` - Destination file path

#### Exit codes

- `0` - Something changed
- `1` - Nothing changed

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
