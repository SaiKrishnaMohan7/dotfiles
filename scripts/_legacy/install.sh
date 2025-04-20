#!/bin/bash

read -p "This will install Homebrew. Continue? (y/n): " -n 1 -r
echo    # move to new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
