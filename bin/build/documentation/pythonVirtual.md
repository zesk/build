## `pythonVirtual`

> Set up a virtual environment for a project and install

### Usage

    pythonVirtual --application directory [ --require requirements ] [ pipPackage ... ] [ --help ] [ --handler handler ]

Set up a virtual environment for a project and install dependencies. Also can be used to update dependencies or add them.
When completed, a directory `.venv` exists in your project containing dependencies.

### Arguments

- `--application directory` - Directory. Required. Path to project location.
- `--require requirements` - File. Optional. Requirements file for project.
- `pipPackage ...` - String. Optional. One or more pip packages to install in the virtual environment.
- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

