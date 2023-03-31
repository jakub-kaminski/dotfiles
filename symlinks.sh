#!/bin/bash

# This script will create symlinks to the home directory from any desired dotfiles in ~/dotfiles
for file in $(find . -maxdepth 1 -type f -name '.*'); do
    #if file is not .gitignore
    if [ "${file}" != ".gitignore" ]; then
        ln -sf $(pwd)/${file} ~/${file}
    fi
done

for dir in $(find . -maxdepth 1 -type d -name '.*'); do
    if [ "${dir}" != "." ] && [ "${dir}" != ".." ] && [ "${dir}" != ".git" ]; then
        ln -sfn $(pwd)/${dir} ~/${dir}
    fi
done

