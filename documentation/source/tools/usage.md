# Usage Functions

<!-- TEMPLATE toolHeader 2 -->
[🛠️ Tools ](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

Usage refers to displaying an error which shows the proper usage of a program to the user or controlling program.

Essentially a `usage` function is a error handler and should adhere to that interface, which is two arguments:

- `returnCode` - *UnsignedInteger*. **Required.** The return code to handle. Can be 0 or greater,
- `message` ... - *String*. **Optioal.** Message to display.

The most basic error handler is `{SEE:returnMessage}`, which can be used as a default when you do not want to define
your own.

Error handlers are internally written as the function name with an underscore prefix:

    myFunction() {
        ...
    }   
    _myFunction() {
        # You can add custom handling code here if desired.
        # __IDENTICAL__ usageDocument 1
        usageDocument "${BASH_SOURCE[0]}" "${FUNCNAME[0]#_}" "$@"
        # You can add additional handling code here if desired.
    }

## Usage formatting

{usageDocument}

{usageDocumentSimple}

## Environment

{usageRequireBinary}

{usageRequireEnvironment}

## Argument validation

For argument validation, use [validate](./validate.md).

## Internal Functions

{__functionSettings}

{__usageDocumentCached}

{__usageMessage}

{__usageMessageStyle}
