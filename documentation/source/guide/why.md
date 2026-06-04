# Why {applicationName}

<!-- TEMPLATE guideHeader 1 -->
<hr />

## Why use {applicationName}?

The most compelling reason for using this toolkit is **simple, readable** consistency across projects and platforms
using a tool
which is universally available on nearly every platform on the planet and uses consistent, tested and documented tools
which are open source.

If you live in your shell, and use **Bash** – we recommend you check out the [functionality](../tools/index.md) which is
offered and see if it will work for your projects. **{applicationName}** eats its own dog food so this tool is used in
production environments and configures remote pipelines identically, delivers credentials to developers and keeps our
credentials synchronized using an add-on library called **Infrastructure**
which manages infrastructure configuration in the cloud using `Terraform` or `OpenTofu` and deploying of **Development
Operations** values used for any number of configuration environments.

## Why was it built?

- Had a littering of eerily similar shell scripts in every project
- Rewriting the same shell function in many places in many projects created debt to keep projects and code in sync
- Generally speaking, patterns in Bash are consistent
- System tools and flags for shell binaries used across platforms are **inconsistent** - this toolkit isolates and
  minimizes the platform dependencies.
- Lazy programmers like the author can't remember most flags for command line utilities
- Useful to have a toolkit that operates outside the default application languages (isolation, independence)
- Useful to have a toolkit with few dependencies that can fully configure and set up **other platforms** in a
  platform-independent language (`bash`)
- The `iTerm2` integration makes customizing project workflow and color schemes for terminals super simple
- As far as my research goes; there are no assertion or validation libraries available which work well with Bash
- "Oh yeah, I forgot that timeouts for `read` don't work the same when we switched from `Ubuntu` to `Alpine` distros for
  our application."
- `identicalCheck` was written and then became sort of part of the way this toolkit is built.
- Everyone invents their own decoration libraries, so why not? Wink.

## Why `bash`?

- Raw `sh` is too primitive and `bash` is universally available across platforms and systems
- Is familiar to most developers who communicate with *nix cloud systems
- Open source, supported by GNU, installed on Debian, Ubuntu, macOS and most Unix variants

## Why `Zesk`?

Market Acumen, Inc. which owns the copyrights to this software, registered the domain name `zesk.com` which is short and
memorable and has been working on building software technologies around that name. Another toolkit [Zesk for
PHP](https://github.com/zesk/zesk) shares the name.

The name is sort of like **desk** or **zest** which is a nice association for software which helps you build software.

## Why Bash 3 support and not Bash 4?

Honestly our development is primarily on **macOS** which has stubbornly fixed on Bash 3 and since set the default shell
to `zsh`.

It has **not** been a challenge to remain compatible with **Bash 3** so until that becomes a burden the intent is to
maintain support of **Bash 3** and greater until they pry it from my cold, dead fingers. Or I change my mind.

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
