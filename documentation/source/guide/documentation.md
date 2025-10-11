# Documentation

Zesk Build has some documentation tools which can be used in any project to document your `bash` code simply.

To add automatic handler for a function, the pattern to use is to add a comment before the function as shown here and
add
a handler handler which is your function name prefixed with a single underscore (`_`):

    # Lay an egg
    layAnEgg() {
        local handler="_${FUNCNAME[0]}"
        ...
        [ -n "$hay" ] || throwEnvironment "$handler" "No hay" || return $?
        ...
    }
    _layAnEgg() {
      # __IDENTICAL__ usageDocument 1 
      usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

To add `--help` support for simple functions, use the `__help` function:

    [ $# -eq 0 ] || __help --only "_${FUNCNAME[0]}" "$@" || return 0

The above will add `myFunction --help` support for simple functions as well as error handling. In the above example,
when the

    No hay
    
    Usage: layAnEgg
    
    Lay an egg

You can add arguments, exit codes, summary lines, or even rename the function to something else in the documentation:

    # fn: makeCryptoThing
    # Lay an egg. You can use `markdown` in *here*. **Cool**.
    #
    #     Displayed as code
    #
    # No animal was harmed in the making of this example.
    # Argument: name - String. Required. What to name the egg.
    # Argument: --debug - Flag. Optional. Turn on debugging.`
    # Return Code: 0 - Success
    # Return Code: 1 - Environment error
    # Return Code: 2 - Argument error
    # Example:     {fn} newEgg
    # stdout: Eggs laid: 2000
    layAnEgg() {
        [ "$1" != "--help" ] || __help "_${FUNCNAME[0]}" "$@" || return 0
        ...
    }
    _layAnEgg() {
        # __IDENTICAL__ usageDocument 1
        usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
    }

Will generate:

    Usage: makeCryptoThing name [ --debug ]
    
        name     String. Required. What to name the egg.
        --debug  Flag. Optional. Turn on debugging.
    
    Lay an egg. You can use markdown in here. Cool.
    
        Displayed as code
    
    No animal was harmed in the making of this example.
    
    Return codes:
    - 0 - Success
    - 1 - Environment error
    - 2 - Argument error
    
    Writes to stdout:
    Eggs laid: 2000
    
    Example:
    makeCryptoThing newEgg

Similarly the same can be converted into our [amazing online documentation](/).
