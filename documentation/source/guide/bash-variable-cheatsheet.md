# Bash Substitution Cheatsheet

<!-- TEMPLATE guideHeader 2 -->
[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
<hr />

Took forever for me to understand the purpose of Bash `#` and `%` substitutions - they are immensely useful for string
manipulation in your scripts. Largely because I had to look them up each time I needed to use them.

First, as a key to remembering how they operate, they both REMOVE part of the variable value; either from the beginning
of the string or the end of the string.

To remember which is which, on **my** keyboard (and here I'll say my keyboard layout as United States which may not be
helpful to other keyboard layouts) `#` (Shift 3) is to the left of `%` (Shift 5) on my keyboard so I use this to
remember which is which:

- `#` cuts from the beginning of the string
- `%` cuts from the end of the string

And you supply a pattern to match to remove.

Where do I use this? A simple search of Zesk Build code shows:

### Faster `dirname`

Any file path, do:

    parentDirectory="${filePath%/*}"

To do `dirname` but faster. (No subshell)

### Remove directory trailing slash

Ensure your paths concatenate cleanly:

    home=${home%/}

### Ensure single slash separates paths

If you don't want to modify the path for reasons:

    newPath="${currentPath%/*}/$fileBase"

### Easy file extensions removal:

Remove a file extension:

    while read -r name; do printf "%s\n" "${name%.sh}"; done < <(find . -name '*.sh') 

<!-- TEMPLATE guideFooter 3 -->
<hr />

[🛠️ Guide](./index.md) &middot; [⬅ Home ](../index.md)
