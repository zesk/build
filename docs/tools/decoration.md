# Decoration Functions

Typically used to output text to the console using pretty colors and ANSI art.

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


#### Usage

    repeat count string [ ... ]
    

#### Arguments



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



#### Examples

    consoleSuccess $(echoBar =-)
    consoleSuccess $(echoBar "- Success ")
    consoleMagenta $(echoBar +-)

#### Exit codes

- `0` - Always succeeds

#### Environment

Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.
Unable to find "prefixLines" (using index "/root/.build")

### `wrapLines` - Prefix output lines with a string

Wrap lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

#### Usage

    wrapLines [ --fill ] [ prefix [ suffix ... ] ] < fileToWrapLines
    

#### Arguments



#### Examples

    cat "$file" | wrapLines "$(consoleCode)" "$(consoleReset)"
    cat "$errors" | wrapLines "    ERROR: [" "]"

#### Exit codes

- 0

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

### `alignRight` - align text right

Format text and align it right using spaces.

#### Usage

    alignRight characterWidth text [ ... ]
    

#### Arguments



#### Examples

    printf "%s: %s\n" "$(alignRight 20 Name)" "$name"
    printf "%s: %s\n" "$(alignRight 20 Profession)" "$occupation"
                Name: Juanita
          Profession: Engineer

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

### `alignLeft` - align text left

Format text and align it left using spaces.

#### Usage

    alignLeft characterWidth text [ ... ]
    

#### Arguments



#### Examples

    printf "%s: %s\n" "$(alignLeft 14 Name)" "$name"
    printf "%s: %s\n" "$(alignLeft 14 Profession)" "$occupation"
    Name          : Tyrone
    Profession    : Engineer

#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

### `boxedHeading` - Text heading decoration

Heading for section output

#### Usage

    boxedHeading [ --size size ] text [ ... ]
    

#### Arguments



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

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

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

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

### `labeledBigText` - Outputs a label before a bigText for output.

Outputs a label before a bigText for output.

This function will strip any ANSI from the label to calculate correct string sizes.

#### Usage

    labeledBigText [ --top | --bottom ] [ --prefix prefix ] label Text ...
    

#### Arguments



#### Exit codes

- `0` - Always succeeds

#### Errors

Unable to find "prefixLines" (using index "/root/.build")

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
