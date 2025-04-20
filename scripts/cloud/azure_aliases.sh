#!/usr/bin/env bash

####################################################################################
# Azure
####################################################################################
alias azlogin="az login"
alias azlistacc="az account list --output table"
alias azlistsubsinacc="az account subscription list --output table"
alias azlistrginsub="az group list --output table"
alias azlistclusters="az aks list --output table"

function azSwitchSub() {
    echo "run azlistacc and grab the id of the sub you want to switch to"

    az account set --subscription "$1"

    echo "switched to sub $1"
}
function azSetNewClusterContext () {
    echo "run azlistrginsub to get a list of rgs"
    echo "Usage: azSetNewClusterContext <rg> <clusterName>"

    read "rg?Which rg? "
    read "clusterName?cluster name? "

    az aks get-credentials --resource-group $rg --name $clusterName
}