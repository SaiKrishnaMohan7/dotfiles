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
	printf "Clone Repos to use with git worktrees; \n \n"
	vared -p 'Directory Name: ' -c dirName

	printf "Creating Directory, $dirName... \n \n"
	mkdir $dirName
	printf "Cloning into $dirName and creating a .bare directory... \n \n"
	git clone --bare $1 $dirName/.bare
	printf "Creating .git file in $dirName with gitdir set to ./bare \n \n"
	printf "gitdir: ./.bare" > $dirName/.git
	printf "Change dir to $dirName/.bare to run git commads \n \n"
	cd $dirName/.bare
	# Explicitly sets the remote origin fetch so we can fetch remote branches
	git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
	# Gets all branches from origin
	git fetch origin
	printf "Change directory $dirName"
	cd ..
	printf "DONE..."
}

function newWorktree() {
	vared -p 'branch name: ' -c branchName
	vared -p 'folderNameOrPath: ' -c folderNameOrPath
	vared -p 'origin branch name: ' -c originBranchName
	vared -p 'app name: ' -c appName

	printf "###Creating new worktree in folder: $folderNameOrPath, branch: $branchName, branchOffOf: $originBranchName \n \n"
	gwa -b $branchName $folderNameOrPath $originBranchName

	printf ">>>cd into $folderNameOrPath \n \n"
	cd $folderNameOrPath

	printf "###Copying dev env file to your new worktree at: $folderNameOrPath \n \n"
	cp ../develop/.env .

	printf ">>>Copying .vscode new worktree at: $folderNameOrPath \n \n"
	cp -R ../develop/.vscode .

	printf "###Running npm install... \n \n"
	npm i

	printf ">>> cd into apps/$appName \n \n"
	cd apps/aquacams/$appName

	printf "### Running docker-compose up... \n \n"
	docker-compose up -d

	printf ">>>Opening VSC in $folderNameOrPath \n \n"
	cd ../../..
	code .

	printf "DONE..."
}

function rmWorktree() {
	vared -p 'folderNameOrPath to delete: ' -c folderNameOrPathToDelete
	vared -p 'branch name to remove: ' -c branchNameToRemove

	printf "deleting folder: $folderNameOrPathToDelete and branch: $branchNameToRemove \n \n"

	gwr $folderNameOrPathToDelete; git branch -D $branchNameToRemove

	printf "DONE..."
}