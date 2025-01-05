# Vendor Functions

<!-- TEMPLATE header 2 -->
[⬅ Top](index.md) [⬅ Parent ](../index.md)
<hr />

### `contextOpen` - Open a file in a shell using the program we

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

- Location: `bin/build/tools/vendor.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

EDITOR - Used as a default editor (first)
VISUAL - Used as another default editor (last)
### `isPHPStorm` - Are we within the JetBrains PHPStorm terminal?

Are we within the JetBrains PHPStorm terminal?

- Location: `bin/build/tools/vendor.sh`

#### Usage

    isPHPStorm
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - within the PhpStorm terminal
- `1` - not within the PhpStorm terminal AFAIK
### `isPyCharm` - Are we within the JetBrains PyCharm terminal?

Are we within the JetBrains PyCharm terminal?

- Location: `bin/build/tools/vendor.sh`

#### Usage

    isPyCharm
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - within the PyCharm terminal
- `1` - not within the PyCharm terminal AFAIK
### `isVisualStudioCode` - Are we within the Microsoft Visual Studio Code terminal?

Are we within the Microsoft Visual Studio Code terminal?

- Location: `bin/build/tools/vendor.sh`

#### Usage

    isVisualStudioCode
    

#### Arguments

- No arguments.

#### Exit codes

- `0` - within the Visual Studio Code terminal
- `1` - not within the Visual Studio Code terminal AFAIK
### `brewInstall` - Install Homebrew

Install Homebrew

- Location: `bin/build/tools/brew.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error
### `isBitBucketPipeline` - Are we currently in the BitBucket pipeline?

Are we currently in the BitBucket pipeline?

- Location: `bin/build/tools/bitbucket.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - is BitBucket pipeline
- `1` - Not a BitBucket pipeline
### `showContext` - Open a file in a shell using the program we

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

- Location: `bin/build/tools/vendor.sh`

#### Arguments

- No arguments.

#### Exit codes

- `0` - Success
- `1` - Environment error
- `2` - Argument error

#### Environment

EDITOR - Used as a default editor (first)
VISUAL - Used as another default editor (last)
