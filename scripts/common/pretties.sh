#!/usr/bin/env bash

if command -v neofetch &> /dev/null
then
    neofetch
fi

# Use bat for pretty file viewing
alias cat="bat"
alias less="bat"