# Decoration Functions

Typically used to output text to the console using pretty colors and ANSI art.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


#### Usage

    repeat count string [ ... ]
    

#### Arguments

- `count` - Required, integer count of times to repeat
- `string` - A sequence of characters to repeat
- `...` - Additional arguments are output using shell expansion of `$*`

#### Examples

    echo $(repeat 80 =)
    echo Hello world
    echo $(repeat 80 -)

#### Exit codes

- `0` - Always succeeds

### `echoBar` - Output a bar as wide as the console using the

Output a bar as wide as the console using the `=` symbol.

#### Usage

    echoBar [ alternateChar [ offset ] ]
    

#### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)

#### Examples

    consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

#### Exit codes

- `0` - Always succeeds

#### Environment

Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.

### `prefixLines` - Prefix output lines with a string

Prefix output lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

#### Usage

    prefixLines [ text .. ] < fileToPrefixLines
    

#### Arguments

- `text` - Prefix each line with this text

#### Examples

    cat "$file" | wrapLines "$(consoleCode)" "$(consoleReset)"
    cat "$errors" | prefixLines "    ERROR: "

#### Exit codes

- 0

### `wrapLines` - Prefix output lines with a string

Wrap lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

#### Usage

    wrapLines [ prefix [ suffix ... ] ] < fileToWrapLines
    

#### Arguments

- `prefix` - Prefix each line with this text
- `suffix` - Prefix each line with this text

#### Examples

    cat "$file" | wrapLines "$(consoleCode)" "$(consoleReset)"
    cat "$errors" | prefixLines "    ERROR: "

#### Exit codes

- 0

### `alignRight` - align text right

Format text and align it right using spaces.

#### Usage

    alignRight characterWidth text [ ... ]
    

#### Arguments

- `characterWidth` - Characters to align right
- `text ...` - Text to align right

#### Examples

    printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
    printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer

#### Exit codes

- `0` - Always succeeds

### `alignLeft` - align text left

Format text and align it left using spaces.

#### Usage

    alignLeft characterWidth text [ ... ]
    

#### Arguments

- `characterWidth` - Characters to align left
- `text ...` - Text to align left

#### Examples

    printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer

#### Exit codes

- `0` - Always succeeds

### `boxedHeading` - Text heading decoration

Heading for section output

#### Usage

    boxedHeading [ --size size ] text [ ... ]
    

#### Arguments

- `--size size` - Optional. Integer. Number of liens to output. Defaults to 1.
- `text ...` - Text to put in the box

#### Examples

    boxedHeading Moving ...

#### Sample Output

    +================================================================================================+
    |                                                                                                |
    | Moving ...                                                                                     |
    |                                                                                                |
    +================================================================================================+
    

#### Exit codes

- `0` - Always succeeds

### `bigText` - smblock (regular)

smblock (regular)

▌  ▗   ▀▛▘     ▐
▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀

smmono12 (--bigger)

▗▖     █       ▗▄▄▄▖
▐▌     ▀       ▝▀█▀▘           ▐▌
▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
        ▜█▛▘

#### Usage

    bigText [ --bigger ] Text to output
    

#### Exit codes

- `0` - Always succeeds

### `labeledBigText` - Outputs a label before a bigText for output.

Outputs a label before a bigText for output.

This function will strip any ANSI from the label to calculate correct string sizes.

#### Arguments

- `--top` - Optional. Flag. Place label at the top.
- `--bottom` - Optional. Flag. Place label at the bottom.
- `--prefix prefixText` - Optional. String. Optional prefix on each line.
- `--tween tweenText` - Optional. String. Optional between text after label and before `bigText` on each line (allows coloring or other decorations).
- `--suffix suffixText` - Optional. String. Optional suffix on each line.
- `label` - Required. String. Label to place on the left of big text.
- `text` - Required. String. Text for `bigText`.

#### Exit codes

- `0` - Always succeeds

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
