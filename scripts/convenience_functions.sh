#!/usr/bin/env bash

#=== FUNCTION ==================================================================
#        NAME:  searchfn
# DESCRIPTION:  Search that matches all files in the current directory or its
#               subdirectories with the given text anywhere in their file name
#===============================================================================
function searchfn {
  find . -regex ".*$1[^\/]*$" 2>/dev/null
}

#=== FUNCTION ==================================================================
#        NAME:  Port scan
# DESCRIPTION:  Scans the give port to check what is using the port
#===============================================================================
function portScan() {
    lsof -nP -i:"$1" | grep LISTEN
}

#=== FUNCTION ==================================================================
#        NAME:  List installed packages
# DESCRIPTION:  Lists installed packages
#===============================================================================
function listInstalledPackages() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        echo "OS is linux; Pipe grep to look for specifics"
        sleep 5
        apt list --installed
    else
        echo "OS is Mac"
        brew list
    fi

}