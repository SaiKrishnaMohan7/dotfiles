#!/usr/bin/env bash

####################################################################################
# FOLDER NAV ALIASES
####################################################################################
export PROJECTS="$HOME/projects"
export WORK="$PROJECTS/work"
export PERSONAL="$PROJECTS/personal"
PERSONAL_SSH="ssh -i ~/.ssh/personal/id_ed25519 -T git@github.com"
WORK_SSH="ssh -i ~/.ssh/work/id_ed25519 -T git@github.com"

# Shows all symlinks at global level
# alias gsym="ls -al $(npm root -g)"
# Shows all symlinks at local level
alias lsym="ls -al ./node_modules"

function goWork() {
  echo "Swtiching to $WORK dir... \n"
  cd $WORK

  echo "Setting the right git credentials"
  git setwork

  echo "using key: $WORK_SSH"

  echo "DONE"
}

function goPersonal() {
  echo "Swtiching to $PERSONAL dir... \n"
  cd $PERSONAL

  echo "Setting the right git credentials"
  git setpersonal

  echo "using key: $PERSONAL_SSH"

  echo "DONE"
}

# replace BSD utils with GNU core utils installed via brew
alias ls="gls --color=auto"
alias cat="bat"  # if you want pretty `cat`, use bat
alias date="gdate"
alias head="ghead"
alias tail="gtail"
alias du="gdu"
alias df="gdf"
alias sort="gsort"
alias cut="gcut"
alias wc="gwc"
alias cp="gcp"
alias mv="gmv"
alias rm="grm"
alias stat="gstat"