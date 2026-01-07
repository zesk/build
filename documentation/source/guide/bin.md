# Direct binaries in Zesk Build

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

The included binaries at `bin/build/` are:

- `tools.sh` - `source` this to load all of Zesk Build. Run it with a defined function to run that function:
  `bin/build/tools.sh urlFetch 'https://.../'`
- `deprecated.sh` - Run this on your code to update it to the latest. May break it, so use source control.
- `repair.sh` - `identicalRepair` with some automatic configuration for your project
- `map.sh` - `mapEnvironment` but can operate standalone (can move and run independently of other code)
- `need-bash.sh` - For Docker image installs which lack bash (usually running `sh`). This script enables install of
  `bash` to run `tools.sh` properly. (used by `alpineContainer` specifically)
- `bash-build.sh` - Ensures base packages in an operating system exist and loads `Zesk Build` and sets up a `.bashrc`
  file with any desired configuration

The other binaries at `bin/build/` are:

- `application.sh` - Copy this to your project to your `bin` directory and create `bin/tools` - loads Zesk Build and
  your tools
- `install.sample.sh` - Create your own `install-bin-build.sh`
- `test.sample.sh` - Create your own `bin/test.sh`

Reviewed: 2026-01-05
