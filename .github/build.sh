#!/usr/bin/env sh
brew upgrade
brew tap ncihnegn/homebrew-formulae
brew install --build-bottle toml11
brew bottle toml11
