#!/usr/bin/env bash

# Helper functions for my dmenu scripts.

output() {
    echo "$@"
}

# Run dmenu with the given args.
# dmenu reads the items from stdin.
# $1 the prompt.
# ${@:2} dmenu args.
# Returns the selected item.
run_dmenu() {
    dmenu -p "$1" "${@:2}"
}

# Run dmenu to confirm choice.
# $1 the prompt.
# ${@:2} dmenu args.
# Returns 0 if yes, 1 otherwise.
confirm_yes() {

    local result
    result=$(printf "No\nYes" | run_dmenu "$1?" "${@:2}")
    output "Confirm is '$result'."

    if [ "$result" == "Yes" ]; then
        return 0
    else
        return 1
    fi
}

# Run the given command.
# $1 the command.
run_command() {
    output "Executing '$1'."
    eval "$1"
}

# $1 The file to source.
source_if_exists() {

    if [ -f "$1" ]; then
        output "Sourcing file $1"
        # shellcheck disable=SC1090
        source "$1"
        return 0
    fi

    return 1
}
