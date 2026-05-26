#!/bin/bash

# Get the sink list from pactl
sink_list=$(pactl list short sinks)

# Build map: simple name -> full sink name
declare -A simple_to_full
choices=()

while IFS= read -r line; do
    full_name=$(echo "$line" | awk '{print $2}')
    if [[ "$full_name" =~ __([^_]+)__ ]]; then
        simple="${BASH_REMATCH[1]}"
    else
        continue
    fi
    simple_to_full["$simple"]="$full_name"
    choices+=("$simple")
done <<< "$sink_list"

# Show tofi menu
selected=$(printf '%s\n' "${choices[@]}" | tofi)

# If a valid selection was made, set the default sink
if [[ -n "$selected" && -n "${simple_to_full[$selected]}" ]]; then
    echo "Setting default sink to: ${simple_to_full[$selected]}"
    pactl set-default-sink "${simple_to_full[$selected]}"
else
    echo "No valid selection made."
fi
