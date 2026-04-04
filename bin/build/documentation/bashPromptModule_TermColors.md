## `bashPromptModule_TermColors`

> Sets the console colors based on the project you are

### Usage

    bashPromptModule_TermColors

Sets the console colors based on the project you are currently in.
Define your color configuration file (values of `bg=FFF` etc. one per line, comments allowed)
Will fill in missing bright or non-bright colors which are unspecified. (`blue` implies `br_blue` and so on)
Sets `decorateStyle` for valid styles
Support for iTerm2 is built-in and automatic

### Arguments

- none

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `term-colors` - When `bashPromptModule_TermColors` is enabled, will show colors and how they are applied

### Examples

    bashPrompt --order 80 bashPromptModule_TermColors

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- {SEE:BUILD_TERM_COLORS_STATE.sh}

