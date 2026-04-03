## `usageDocument`

> Universal error handler for functions (with formatting)

### Arguments

- `functionDefinitionFile` - File. Required. The file in which the function is defined. If you don't know, use `__bashDocumentation_FindFunctionDefinitions` or `__bashDocumentation_FindFunctionDefinition`.
- `functionName` - String. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
- `exitCode` - Integer. Required. The function which actually defines our usage syntax. Documentation is extracted from this function, regardless.
- `message` - String. Optional. A message.

### Debugging settings

Append to the value of `BUILD_DEBUG` (a comma-delimited (`,`) list) and add these tokens to enable debugging:

- `fast-usage` - `usageDocument` does not output formatted help for performance reasons
- `handler` - For all `--help` and any function which uses `usageTemplate` to output documentation (upon error), the stack will be displayed

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- *BUILD_DEBUG* - Add `fast-usage` to make this quicker when you do not care about usage/failure.

