## `bashDocumentation`

> Universal function documentation

### Arguments

- `functionDefinitionFile` - File. Required. The file in which the function is defined. If you don't know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`. (Both SLOW!)
- `functionName` - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
- `returnCode` - Integer. Required. The return code to output.
- `message` - String. Optional. A message to output relating to the return code.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `fast-usage` - `bashDocumentation` does not output formatted help for performance reasons
- `usage-cache-skip` - Skip all caching and generate from scratch
- `handler` - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

