# Guide to types and validation

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

We have an extensive validation library in `validate` and support for argument types in
our [documentation](./documentation.md). The types available for arguments or any variable are:

## String Types

- `EmptyString` - Literally any value, including the empty string, `""`.
- `String` - Any non-empty string.
- `EnvironmentVariable` - A string which can be used as an environment variable (matches expression
  `[A-Za-z_][A-Za-z_0-9]*`)
- `Date` - A string which passed `dateValid`
- `Secret` - A string which represents sensitive authentication information.
- `URL` - A string which passes `urlValid`.

## Number Types

- `Integer` - Any integer
- `Number` - Any number (floating point or integer)
- `UnsignedInteger` - Any integer 0 or greater.
- `PositiveInteger` - Any integer 1 or greater.
- `Boolean` - Only `true` or `false`.
- `Flag` - Used for argument flags like `--debug` or `--verbose`. The presence of the flag sets a value to `true`
  typically.

## Code Types

- `Executable` - A bash binary found in the `PATH`.
- `Function` - A bash function.
- `Callable` - Something which is either `Executable` or `Callable`.

## File and Directory Types

- `Directory` - A directory on the local file system which must exist.
- `DirectoryList` - A list of directories on the local file system which must exist.
- `Exists` - A file or directory which must exist in the file system.
- `File` - A file which which must exist in the file system.
- `FileDirectory` - A file whose parent directory must exist in the file system.
- `Link` - A link which must exist in the file system.
- `RealDirectory` - A directory which is transformed via `realPath` to an absolute directory path which must exist.
- `RealFile` - A file which is transformed via `realPath` to an absolute file path which must exist.
- `RemoteDirectory` - A directory on a remote system.

### Application-relative Types

- `ApplicationDirectory` - A relative directory to the application home
- `ApplicationDirectoryList` - A list of directories relative to the application home
- `ApplicationFile` - A file relative to the application home

## List Types

- `Arguments` - 0 or more additional arguments. Intended to be passed to another callable, usually.
- `Array` - 0 or more additional arguments.
- `ColonDelimitedList` - A string which represents a list of items where `:` is used as a separator between items.
- `CommaDelimitedList` - A string which represents a list of items where `,` is used as a separator between items.
- `List` - 0 or more additional arguments.
