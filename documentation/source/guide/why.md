# Why Zesk Build

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

## Why build it?

- Littering of shell scripts in every project
- Rewriting the same shell code in many places
- Patterns in Bash are consistent
- System tools and flags used across platforms are inconsistent
- Useful to have a toolkit which operates outside the default application languages (isolation, independence)
- Useful to have a toolkit with few dependencies which can fully configure and set up other platforms in a
  platform-independent language
- No assertion libraries available which work well with Bash
- No validation libraries available which work well with Bash
- Everyone invents their own decoration libraries so why not us?

## Why `bash`?

- Raw `sh` is too primitive and `bash` is universally available across platforms and systems
- Is familiar to most developers who communicate with *nix cloud systems
- Open source, supported by GNU, installed on Debian, Ubuntu, macOS and most Unix variants

## Why `Zesk`?

Market Acumen, Inc. which owns the copyrights to this software registered the domain name `zesk.com` which is short and
memorable and has been working on building software technologies around that name. Another toolkit (Zesk for
PHP)(https://github.com/zesk/zesk) shares the name.

The name is sort of like **desk** or **zest** which is a nice association for software which helps you build software.

## Why Bash 3 support and not Bash 4?

Honestly our development is primarily on **macOS** which has stubbornly fixed on Bash 3 and since set the default shell
to `zsh`.

It has **not** been a challenge to remain compatible with **Bash 3** so until that becomes a burden the intent is to maintain
support of **Bash 3** and greater.
