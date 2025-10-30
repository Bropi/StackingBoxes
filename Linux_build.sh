#!/bin/sh
printf '\033c\033]0;%s\a' Stacking Boxes
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Linux_build.x86_64" "$@"
