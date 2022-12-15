#!/usr/bin/env bash

####################################################################################
# GIT
####################################################################################
alias gaa="git add --all"
alias gca="git commit --all -m" #"insert commit message here after a space"
alias gnbr="git checkout -b" #"name/of-new-branch-here-after-a-space"
alias gsa="git status"
alias gm="git checkout main"
alias glo="git log --oneline"
alias gcam="git commit --amend"

alias gw="git worktree"
alias gwa="gw add"
alias gwl="gw list"
alias gwr="gw remove"

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
