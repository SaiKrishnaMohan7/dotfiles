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

# shows you the current branch
alias gbr="git branch"

# update current branch from remote branch
alias gpull="git pull origin" #branch-to-remote-pull-from-into-current-branch

# push current branch to remote equivalent
alias gpush="git push origin" #branch-to-push-to-after-a-space
alias gstash="git stash" # store current branch temporarily

# pull out currently stashed branch: merge into whatever branch is currently open
alias gapply="git stash apply"

function cloneRepo () {
	echo "Clone Repos to use with git worktrees; \n"
	vared -p 'Directory Name: ' -c dirName

	echo "Creating Directory, $dirName... \n"
	mkdir $dirName
	echo "Cloning into $dirName and creating a .bare directory... \n"
	git clone --bare $1 $dirName/.bare
	echo "Creating .git file in $dirName with gitdir set to ./bare \n"
	echo "gitdir: ./.bare" > $dirName/.git
	echo "Change dir to $dirName/.bare to run git commads \n"
	cd $dirName/.bare
	# Explicitly sets the remote origin fetch so we can fetch remote branches
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
	# Gets all branches from origin
	git fetch origin
	echo "Change directory $dirName"
	cd ..
	echo "DONE..."
}
