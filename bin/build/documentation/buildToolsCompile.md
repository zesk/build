## `buildToolsCompile`

> Experimental - resulting file ends up being around 1MB

### Usage

    buildToolsCompile

Experimental - resulting file ends up being around 1MB

### Arguments

- none

### Examples

    timing executeCount 100 source bin/build/tools.sh ; timing executeCount 100 source bin/build/tools-compiled.sh
    executeCount 100 source bin/build/tools.sh 8.628 seconds
    executeCount 100 source bin/build/tools-compiled.sh 7.728 seconds

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

