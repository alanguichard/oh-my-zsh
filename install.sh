#!/bin/bash

# Installs this configuration in the current user's linux machine.

DIR=$(pwd)

git submodule update --init

cd ..
ln -i -s $DIR/zshrc .zshrc
ln -i -s $DIR/.gitconfig .gitconfig
