## `validate`

> Validate a value by type

### Usage

    validate handler type name value

Validation sets are passed as three arguments, optionally repeated: `type` `name ` `value`
Types are case-insensitive:
#### Text and formats
- `EmptyString` - (alias `string?`, `any`) - Any value at all
- `String` - (no aliases) - Any non-empty string
- `EnvironmentVariable` - (alias `env`) - A non-empty string which contains alphanumeric characters or the underscore and does not begin with a digit.
- `Secret` - (no aliases) - A value which is security sensitive
- `Date` - (no aliases) - A valid date in the form `YYYY-MM-DD`
- `URL` - (no aliases) - A Universal Resource Locator in the form `scheme://user:password@host:port/path`
#### Numbers
- `Flag` - (no aliases) - Presence of an option to enables a feature. (e.g. `--debug` is a `flag`)
- `Boolean` - (alias `bool`) - A value `true` or `false`
- `BooleanLike` - (aliases `boolean?`, `bool?`) - A value which should be evaluated to a boolean value
- `Integer` - (alias `int`) - Any integer, positive or negative
- `UnsignedInteger` - (aliases `uint`, `unsigned`) - Any integer 0 or greater
- `PositiveInteger` - (alias `positive`) - Any integer 1 or greater
- `Number` - (alias `number`) - Any integer or real number
#### File system
- `Exists` - (no aliases - A file (or directory) which exists in the file system of any type
- `File` - (no aliases) - A file which exists in the file system which is not any special type
- `Link` - (no aliases) - A link which exists in the file system
- `Directory` - (alias `dir`) - A directory which exists in the file system
- `DirectoryList` - (alias `dirlist`) - One or more directories as arguments
- `FileDirectory` - (alias `parent`) - A file whose directory exists in the file system but which may or may not exist.
- `RealDirectory` - (alias `realdir`) - The real path of a directory which must exist.
- `RealFile` - (alias `real`) - The real path of a file which must exist.
- `RemoteDirectory` - (alias `remotedir`) - The path to a directory on a remote host.
#### Application-relative
- `ApplicationDirectory` - (alias `appdir`) - A directory path relative to `BUILD_HOME`
- `ApplicationFile` - (alias `appfile`) - A file path relative to `BUILD_HOME`
- `ApplicationDirectoryList` - (alias `appdirlist`) - One or more arguments of type `ApplicationDirectory`
#### Functional
- `Type` - (no aliases) - A type which can be validated by `validate`
- `Function` - (alias `function`) - A defined function
- `Callable` - (alias `callable`) - A function or executable
- `Executable` - (alias `bin`) - Any binary available within the `PATH`
#### Lists
- `Array` - (no aliases) - Zero or more arguments
- `List` - (no  aliases) - Zero or more arguments
- `ColonDelimitedList` - (alias `list:`) - A colon-delimited list `:`
- `CommaDelimitedList` - (alias `list,`) - A comma-delimited list `,`
You can repeat the `type` `name` `value` more than once in the arguments and each will be checked until one fails
`validate` is intended to be extensible as well as reducible to smaller sizes by limiting type validation to used
types only. The core validation types can be used **CASE-SENSITIVE ONLY** in smaller scripts using the core `validate`
identical document which includes:
- `String`
- `PositiveInteger`
- `Function`
- `Callable`
- `Type`
The function `_validateTypeMapper` is defined and can map types to internal types. If not present, then no conversion
is done. For a type to be considered valid, the corresponding `__validateType` prefixed function **MUST** exist.
Internally the function `_validateTypeMapperDefault` is the default type mapper and does the stringLowercase and alias lookups.

### Arguments

- `handler` - Function. Required. Error handler.
- `type` - Type. Required. Type to validate. If more than validation set is specified, specifying a `type` of "" inherits the previous `type`. Blank `types` are not allowed.
- `name` - String. Required. Name of the variable which is being validated. If more than validation set is specified, specifying a name of "" inherits the previous name. Blank names are not allowed.
- `value` - EmptyString. Required. Value to validate.

### Return codes

- `0` - `value` is valid, stdout is a filtered version of the value to be used
- `2` - `value` is invalid, output reason to stderr
- `120` - `value` is invalid, return calling function immediately

