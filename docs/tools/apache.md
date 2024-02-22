# Apache Functions

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)


### `installApacheConfiguration` - Configures Apache

Configures Apache

                     ▗▖         ▄▄▖
                     ▐▌        ▐▀▀█▖
  ▟██▖▐▙█▙  ▟██▖ ▟██▖▐▙██▖ ▟█▙    ▐▌
  ▘▄▟▌▐▛ ▜▌ ▘▄▟▌▐▛  ▘▐▛ ▐▌▐▙▄▟▌  ▗▛
 ▗█▀▜▌▐▌ ▐▌▗█▀▜▌▐▌   ▐▌ ▐▌▐▛▀▀▘ ▗▛
 ▐▙▄█▌▐█▄█▘▐▙▄█▌▝█▄▄▌▐▌ ▐▌▝█▄▄▌▗█▄▄▖
  ▀▀▝▘▐▌▀▘  ▀▀▝▘ ▝▀▀ ▝▘ ▝▘ ▝▀▀ ▝▀▀▀▘
      ▐▌

#### Arguments

- `applicationsHome` - Home directory for the application. User is derived from the owner.
- `--site-remove siteName` - Explicitly disable site

#### Exit codes

- `0` - Always succeeds

#### Environment

APPLICATION_USER - Automatically defined and used to map `.conf` files
APPLICATION_PATH - Automatically defined and used to map `.conf` files
APPLICATION_NAME - Automatically defined and used to map `.conf` files

[⬅ Return to index](index.md)
[⬅ Return to top](../index.md)
