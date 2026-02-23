#!/bin/bash

# This script creates symlinks from the dotfiles repo to $HOME.
# Run from the root of the dotfiles repo: ./symlinks.sh

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# Symlink top-level dotfiles (skip .gitignore)
for file in "$DOTFILES_DIR"/.*; do
    [ -f "$file" ] || continue
    name="$(basename "$file")"
    [ "$name" = ".gitignore" ] && continue
    ln -sf "$file" "$HOME/$name"
    echo "Linked file: $name"
done

# Symlink top-level dot-directories (skip .git, .config)
for dir in "$DOTFILES_DIR"/.*; do
    [ -d "$dir" ] || continue
    name="$(basename "$dir")"
    case "$name" in
        .|..|.git|.config) continue ;;
    esac
    ln -sfn "$dir" "$HOME/$name"
    echo "Linked directory: $name"
done

# Symlink tmux.conf to ~/.tmux.conf (tmux expects it there)
ln -sf "$DOTFILES_DIR/.tmux/tmux.conf" "$HOME/.tmux.conf"

# Symlink each .config subdirectory individually
# (so we don't clobber other things in ~/.config)
home_config="$HOME/.config"
mkdir -p "$home_config"

for dir in "$DOTFILES_DIR/.config"/*/; do
    [ -d "$dir" ] || continue
    dir_name="$(basename "$dir")"

    target="$home_config/$dir_name"
    if [ -L "$target" ]; then
        rm "$target"
    elif [ -d "$target" ]; then
        echo "WARNING: $target is a real directory, skipping (back it up and remove it manually)"
        continue
    fi

    ln -s "$dir" "$target"
    echo "Linked .config/$dir_name"
done

echo "Done. All symlinks created."
