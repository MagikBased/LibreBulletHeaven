#!/bin/sh
echo -ne '\033c\033]0;Libre Bullet Heaven\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/LibreBulletHeaven.x86_64" "$@"
