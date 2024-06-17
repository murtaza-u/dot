#!/usr/bin/env bash

set -e

list=(
    # fill me
)

echo "\"Group\",\"Title\",\"Password\",\"TOTP\""

for x in "${list[@]}"; do
    field="${x##*/}"
    title="$(sed 's/.*/\L&/; s/[a-z]*/\u&/g; s/-/ /g' <<< "$field")"

    group="${x%/*}"
    if [[ $group == *otp ]]; then
        continue
    fi

    base="$group/"
    if [[ "$group" == "$x" ]]; then
        group="personal"
        base=""
    fi

    if [[ -f "$HOME/.agepass/${base}otp/$field" ]]; then
        otp="$(z pass show "${base}otp/$field" | sed 's/"/\\"/g')"
    else
        otp=""
    fi
    pswd="$(z pass show "$x" | sed 's/"/\\"/g')"

    echo "\"Root/${group}\",\"${title}\",\"${pswd}\",\"${otp}\""
done
