# Decoration Functions

Typically used to output text to the console using pretty colors and ANSI art.

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `repeat` - Repeat a string

Repeat a string

- Location: `bin/build/tools/decoration.sh`

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `echoBar` - Output a bar as wide as the console using the

Output a bar as wide as the console using the `=` symbol.

- Location: `bin/build/tools/decoration.sh`

#### Usage

    echoBar [ alternateChar [ offset ] ]
    

#### Arguments

- `alternateChar` - Use an alternate character or string output
- `offset` - an integer offset to increase or decrease the size of the bar (default is `0`)

#### Examples

    decorate success $(echoBar =-)
    decorate success $(echoBar "- Success ")
    decorate magenta $(echoBar +-)

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

Console width is captured using `tput cols` or if no `TERM` set, then uses the value 80.
### `wrapLines` - Prefix output lines with a string

Wrap lines with a string, useful to format output or add color codes to
consoles which do not honor colors line-by-line. Intended to be used as a pipe.

- Location: `bin/build/tools/decoration.sh`

#### Usage

    wrapLines [ --fill ] [ prefix [ suffix ... ] ] < fileToWrapLines
    

#### Arguments

- `prefix` - Prefix each line with this text
- `suffix` - Prefix each line with this text

#### Examples

    cat "$file" | wrapLines "$(decorate code)" "$(decorate reset)"
    cat "$errors" | wrapLines "    ERROR: [" "]"

#### Exit codes

- 0
### `alignRight` - align text right

Format text and align it right using spaces.

- Location: `bin/build/tools/decoration.sh`

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `alignLeft` - align text left

Format text and align it left using spaces.

- Location: `bin/build/tools/decoration.sh`

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `boxedHeading` - Text heading decoration

Heading for section output

- Location: `bin/build/tools/decoration.sh`

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

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `bigText` - Display large text in the console for banners and important

Display large text in the console for banners and important messages


standard (figlet)

     _     _      _____         _
    | |__ (_) __ |_   _|____  _| |_
    | '_ \| |/ _` || |/ _ \ \/ / __|
    | |_) | | (_| || |  __/>  <| |_
    |_.__/|_|\__, ||_|\___/_/\_\\__|
             |___/

--bigger (figlet)

     _     _    _______        _
    | |   (_)  |__   __|      | |
    | |__  _  __ _| | _____  _| |_
    | '_ \| |/ _` | |/ _ \ \/ / __|
    | |_) | | (_| | |  __/>  <| |_
    |_.__/|_|\__, |_|\___/_/\_\\__|
              __/ |
             |___/

smblock (regular) toilet

    ▌  ▗   ▀▛▘     ▐
    ▛▀▖▄ ▞▀▌▌▞▀▖▚▗▘▜▀
    ▌ ▌▐ ▚▄▌▌▛▀ ▗▚ ▐ ▖
    ▀▀ ▀▘▗▄▘▘▝▀▘▘ ▘ ▀

smmono12 (--bigger) toilet

    ▗▖     █       ▗▄▄▄▖
    ▐▌     ▀       ▝▀█▀▘           ▐▌
    ▐▙█▙  ██   ▟█▟▌  █   ▟█▙ ▝█ █▘▐███
    ▐▛ ▜▌  █  ▐▛ ▜▌  █  ▐▙▄▟▌ ▐█▌  ▐▌
    ▐▌ ▐▌  █  ▐▌ ▐▌  █  ▐▛▀▀▘ ▗█▖  ▐▌
    ▐█▄█▘▗▄█▄▖▝█▄█▌  █  ▝█▄▄▌ ▟▀▙  ▐▙▄
    ▝▘▀▘ ▝▀▀▀▘ ▞▀▐▌  ▀   ▝▀▀ ▝▀ ▀▘  ▀▀
               ▜█▛▘

- Location: `bin/build/tools/decoration.sh`

#### Usage

    bigText [ --bigger ] Text to output
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `labeledBigText` - Outputs a label before a bigText for output.

Outputs a label before a bigText for output.

This function will strip any ANSI from the label to calculate correct string sizes.

- Location: `bin/build/tools/decoration.sh`

#### Arguments

- `--top` - Optional. Flag. Place label at the top.
- `--bottom` - Optional. Flag. Place label at the bottom.
- `--prefix prefixText` - Optional. String. Optional prefix on each line.
- `--tween tweenText` - Optional. String. Optional between text after label and before `bigText` on each line (allows coloring or other decorations).
- `--suffix suffixText` - Optional. String. Optional suffix on each line.
- `label` - Required. String. Label to place on the left of big text.
- `text` - Required. String. Text for `bigText`.

#### Examples

    > bin/build/tools.sh labeledBigText --top "Neat: " Done
    Neat: ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
          ▀▀ ▝▀ ▘ ▘▝▀▘
    > bin/build/tools.sh labeledBigText --bottom "Neat: " Done
          ▛▀▖
          ▌ ▌▞▀▖▛▀▖▞▀▖
          ▌ ▌▌ ▌▌ ▌▛▀
    Neat: ▀▀ ▝▀ ▘ ▘▝▀▘

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `lineFill` - Output a line and fill columns with a character

Output a line and fill columns with a character

- Location: `bin/build/tools/decoration.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `decoratePath` - Replace an absolute path prefix with an icon if it

Replace an absolute path prefix with an icon if it matches HOME or BUILD_HOME

- Location: `bin/build/tools/decoration.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
