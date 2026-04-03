## `buildUsageCompileParallel`

> **Experimental**: Compile usage using multiple processes and a writer and

### Usage

    buildUsageCompileParallel [ --help ] [ --handler handler ] [ --workers workerCount ] [ --all ] [ --clean ]

**Experimental**: Compile usage using multiple processes and a writer and several readers.

### Arguments

- `--help` - Flag. Optional. Display this help.
- `--handler handler` - Function. Optional. Use this error handler instead of the default error handler.
- `--workers workerCount` - PositiveInteger. Optional. Create this many workers to do the job.
- `--all` - Flag. Optional. Check and build all of the build functions usage data.
- `--clean` - Flag. Optional. Delete all usage files before starting.

### Return codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

