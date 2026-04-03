## `labeledBigText`

> Outputs a label before a decorate big for output.

### Usage

    labeledBigText [ --top ] [ --bottom ] [ --prefix prefixText ] [ --tween tweenText ] [ --suffix suffixText ] label text

Outputs a label before a decorate big for output.
This function will strip any ANSI from the label to calculate correct string sizes.

### Arguments

- `--top` - Flag. Optional. Place label at the top.
- `--bottom` - Flag. Optional. Place label at the bottom.
- `--prefix prefixText` - String. Optional. Optional prefix on each line.
- `--tween tweenText` - String. Optional. Optional between text after label and before `decorate big` on each line (allows coloring or other decorations).
- `--suffix suffixText` - String. Optional. Optional suffix on each line.
- `label` - String. Required. Label to place on the left of big text.
- `text` - String. Required. Text for `decorate big`.

### Examples

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

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

