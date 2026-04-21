#!/bin/bash
path="$1"
config_get() {
    val="$(yq -oy -p toml ".${1}" ~/"$path")";
    if [ "${val}" = "__UNDEFINED__" ]; then
        val="$(yq -oy -p toml ".${1}" "$path")";
    fi
    printf -- "%s" "${val}";
}

