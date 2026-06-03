## `BUILD_CACHE_HOME`

> **Build Cache Directory** &mdash; Location for the build system cache files. Defaults to `$HOME/.build`
> > **Type**: *Directory* • **Category**: *Build Configuration*

Location for the build system cache files. Defaults to `$HOME/.build` and if `$HOME` is not a directory then `$(buildHome)/.build`
Cache MAY be deleted at any time. If you need your files to be preserved, store them elsewhere.

