## `bashDocumentationMissing`

> Generate templates of functions missing from documentation

### Usage

    bashDocumentationMissing --index indexPath --source sourcePath --target templateTarget

Generates:
- `missingFunctionTotal.md`
- `missingFunctionList.md`
in the target directory.

> Location: `bin/build/tools/documentation.sh`

### Arguments

- `--index indexPath` - Directory. Required. Where to store documentation indexes for later use.
- `--source sourcePath` - Directory. Required. The source
- `--target templateTarget` - FileDirectory. Required. Create templates here.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

