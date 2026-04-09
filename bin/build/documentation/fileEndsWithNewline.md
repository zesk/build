## `fileEndsWithNewline`

> Does a file end with a newline or is empty?

### Usage

    fileEndsWithNewline file ...

Does a file end with a newline or is empty?
Typically used to determine if a newline is needed before appending a file.

### Arguments

- `file ...` - File. Required. File to check if the last character is a newline.

### Return codes

- `0` - All files ends with a newline
- `1` - One or more files ends with a non-newline

