# iTerm2 Tools

[iTerm2](https://iterm2.com) is a terminal program with some exceptional features written and maintained by George Nachman and contributors.

Features which make it nice:

- Profiles and hot keys to connect to your favorite hosts
- Terminal colorization and background images, badges and animation
- Apparently amazing `tmux` integration 
- Tons of other features 

**iTerm2** provides shell integration directly which has been implemented, largely, with this library. 

You can do some pretty cool things like:

- Have a color scheme for your project which updates automatically when you are working in that project
- Display images directly in the console
- Directly copy the last command or its output without selecting it

To integrate, do

    ! isITerm2 || iTerm2Init 

Most commands take the `--ignore` parameter if you wish to ignore errors when the current terminal is not `iTerm2`.

{isiTerm2}
{iTerm2Init}
{iTerm2Badge}
{iTerm2Attention}
{iTerm2PromptSupport}
{iTerm2Image}
{iTerm2Download}
{iTerm2Version}
{iTerm2Notify}

# iTerm2 Colors

{iTerm2ColorNames}
{iTerm2ColorTypes}
{iTerm2IsColorName}
{iTerm2IsColorType}
{iTerm2SetColors}

# Aliases for iTerm tools

These aliases are provided by **iTerm2**.

{iTerm2Aliases}
