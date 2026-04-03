## `deployLink`

> Link deployment to new version of the application

### Usage

    deployLink applicationLinkPath [ applicationPath ]

Link new version of application.
When called, current directory is the **new** application and the `applicationLinkPath` which is
passed as an argument is the place where the **new** application should be linked to
in order to activate it.

### Arguments

- `applicationLinkPath` - Path. Required. Path where the link is created.
- `applicationPath` - Path. Optional. Path where the link will point to. If not supplied uses current working directory.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

### Environment

- PWD

