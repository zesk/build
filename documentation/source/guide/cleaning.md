# Bad patterns

Instead of:

    while read -r item; do
        # something with item
    done 

Try:

    local done=false

    while ! $done; do
        read -r item || done=true
        if [ -z "$item" ] && $done; then
            break
        fi
        # something with item
    done

This handles lines and content without a trailing newline better.
