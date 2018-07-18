# Virtual Env Management
export WORKON_HOME=$HOME/Projects/VirtualEnvs
export PROJECT_HOME=$HOME/Projects
source /usr/local/bin/virtualenvwrapper.sh

# NVM and Node things
export NVM_DIR=/Users/saikrishnamohan/.nvm
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # This loads NVM
# nvm use v8.11.2
# nvm use v10.3.0

#theFuck
eval $(thefuck --alias)
########################PIP & PIP3 Isolation to virtualenv#############################

#Use these for global install of site-packages
#This prevents dependency confusion such that each project is isolated in its own venv

gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

#######################################################################################


if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

alias brewpack="brew list"

####################EXPORTS####################
# export PATH=/usr/local/bin:/usr/local/share/python:$PATH

####################################################################################
# DIRECTORY CONTENT LISTING UTILITIES
####################################################################################
# list all files including hidden, with details
alias lsa="ls -ao"

# list files by time, with details, show all including hidden
alias lsar="ls -aort"

# list directories
alias lsd="ls -ao | ack \^d --no-color"

# list files
alias lsf="ls -ao | ack -v \^d --no-color"
####################################################################################

####################################################################################

###################################################################################################
##
##	ENVIRONMENTS
##
###################################################################################################

alias rbash=". ~/.bash_profile"

function goaws(){
    ssh -i "$1" ec2-user@"$2"
}

function deploy(){
    echo "Deploying the current version of the project to Heroku"
    git push heroku
    heroku open
}
####################################################################################

####################################################################################
# GIT
####################################################################################
alias gaa="git add --all"
alias gca="git commit --all -m" #"insert commit message here after a space"
alias gnbr="git checkout develop; git checkout -b" #"name/of-new-branch-here-after-a-space"
alias gsa="git status"

#shows the last 10 branches you were on
alias branchhistory="git for-each-ref --sort=committerdate refs/heads/ --format='%(refname) %(committerdate) %(authorname)' | sed 's/refs\/heads\///g' | awk '{print \$1}' | tail"

# shows you the current branch
alias gbr="git branch"

# update current branch from remote branch 
alias gpull="git pull origin" #branch-to-remote-pull-from-into-current-branch

# push current branch to remote equivalent
alias gpush="git push origin" #branch-to-push-to-after-a-space
alias gstash="git stash" # store current branch temporarily

# pull out currently stashed branch: merge into whatever branch is currently open
alias gapply="git stash apply"

# see differences between given branch and develop branch
function g_diff {
	git diff $1 develop | ack '^-{3}' | awk '{print $2}' 
}

# Works with the above PS1 export.
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
# Returns the current git branch.
currentBranch () {
	git rev-parse --abbrev-ref HEAD
}
# Change terminal prompt to show the git branch.
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# List GIT branches in the order of creation
alias gbl="git for-each-ref --sort=committerdate refs/heads/ --format='%(committerdate:short) %(authorname) %(refname:short)'"

# git merge from another branch: git merge branch-to-merge-from
## note: you'll likely have conflicts. These suck, but are easy enough to deal with
#### just open the files it says are conflicting, and change them accordingly.
###################################################################################

####################################################################################
# NODE
####################################################################################
##alias nrn="npm run nodemon"
alias ns="node server.js"
alias nukenode="ps aux | ack 'npm\|node\|gulp\|nodemon' | awk '{print \$2}' | sudo xargs kill -9"
####################################################################################

#=== FUNCTION ==================================================================
#        NAME:  searchfn
# DESCRIPTION:  Search that matches all files in the current directory or its         
#               subdirectories with the given text anywhere in their file name 
#===============================================================================
function searchfn {
  find . -regex ".*$1[^\/]*$" 2>/dev/null
}


##################################################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AUTOCOMPLETIONS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##################################################################################
#npm autocompletions
. <(npm completion)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
##################################################################################

alias bashprofile="code ~/.bash_profile"

#################################################################################
# CONVENIENCE ALIASES TO NAVIGATE TO PARENT FOLDERS
#################################################################################
alias ..="cd .."
alias ...="cd ..; cd .."
alias ....="cd ..; cd ..; cd .."
alias .....="cd ..; cd ..; cd ..; cd .."
alias ......='cd ..; cd ..; cd ..; cd ..; cd ..'
alias .......='cd ..; cd ..; cd ..; cd ..; cd ..; cd ..'

##########PYTHON RELATED#################
alias p3list="pip3 list"
alias plist="pip list"
alias pReq="pip freeze > requirements.txt"
alias p3Req="pip3 freeze > requirements.txt"
alias p3="python3.6"
alias p="python"
alias p3i="pip3 install"
alias p2i="pip install"

# Function to convert Py2 scripts to Py3
function convertScripts {
    ls *.py | xargs 2to3 -w
}
####################################################################################
# NAVIGATION TO PROJECTS / Tensorflow Aliases
####################################################################################
alias tf="cd tensorflow" 
alias atf="source bin/activate"
alias gonlt="cd Projects/ML/NLTKTutorial"
alias goproj="cd Projects"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH