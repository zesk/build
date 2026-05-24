## `BUILD_ENVIRONMENT_DIRS`

> **BUILD_ENVIRONMENT_DIRS** &mdash; Search directory for environment definition files. `:` separated.
> > **Type**: *DirectoryList* • **Category**: *Build Configuration*

Search directory for environment definition files. `:` separated.
Note these should be *in addition* to the default environment variables ALWAYS located at `$(buildHome)/bin/build/env`
THe default is `$(buildHome)/bin/env`. Make sure to append to this as a `:`-list.

