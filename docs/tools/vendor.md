# Vendor Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `contextOpen` - Open a file in a shell using the program we

Open a file in a shell using the program we are using. Supports VSCode and PHPStorm.

#### Exit codes

- `0` - Always succeeds

#### Environment

EDITOR - Used as a default editor (first)
VISUAL - Used as another default editor (last)

### `isPHPStorm` - Are we within the JetBrains PHPStorm terminal?

Are we within the JetBrains PHPStorm terminal?

#### Usage

    isPHPStorm
    

#### Exit codes

- `0` - within the PhpStorm terminal
- `1` - not within the PhpStorm terminal AFAIK

#### See Also

{SEE:contextOpen}

### `isPyCharm` - Are we within the JetBrains PyCharm terminal?

Are we within the JetBrains PyCharm terminal?

#### Usage

    isPyCharm
    

#### Exit codes

- `0` - within the PyCharm terminal
- `1` - not within the PyCharm terminal AFAIK

#### See Also

{SEE:contextOpen}

### `isVisualStudioCode` - Are we within the Microsoft Visual Studio Code terminal?

Are we within the Microsoft Visual Studio Code terminal?

#### Usage

    isVisualStudioCode
    

#### Exit codes

- `0` - within the Visual Studio Code terminal
- `1` - not within the Visual Studio Code terminal AFAIK

#### See Also

{SEE:contextOpen}

#### Exit codes

- `0` - Always succeeds

#### Usage

    isBitBucketPipeline
    

#### Exit codes

- `0` - is BitBucket pipeline
- `1` - Not a BitBucket pipeline

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
