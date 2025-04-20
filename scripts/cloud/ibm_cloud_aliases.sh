#!/usr/bin/env bash

#=== FUNCTION ==================================================================
#        NAME:  devProxy Functions
# DESCRIPTION:  Starts dev-proxy under sudo
#===============================================================================
function devProxyStart {
    sudo dev-proxy start
}

function devProxyStop {
    sudo dev-proxy stop
}

function devProxyConfigure {
    sudo dev-proxy configure "$1"
}

function iDevProxy {
    sudo npm i -g @ace/local-dev-proxy
}

#=== FUNCTION ==================================================================
#        NAME:  resetPayGoAccount
# DESCRIPTION:  unlink to relink SL accounts and go PayGo
#===============================================================================

function resetPayGoAccount {
    echo "this has to be the master account"
    echo "Requires to be on IBM n/w"
    echo "LOGOUT and log in after curl finishes"
    echo "Usage: resetPayGoAccount <accountId>, ex: resetPayGoAccount 476958142aee46dba4a01b6e0ee6e481"

    curl -X POST https://temporary-app.stage1.ng.bluemix.net/reset_to_trial_for_testing?account_id="$1" -H 'authorization: Basic SUJNQmx1ZW1peEJTU1JvY2tzIQ=='
}

#=== FUNCTION ==================================================================
#        NAME:  getMeToken
# DESCRIPTION:  Gets an IAM token
#===============================================================================

function getMeToken() {
    curl -k -X POST   --header "Content-Type: application/x-www-form-urlencoded"   --header "Accept: application/json"   --data-urlencode "grant_type=urn:ibm:params:oauth:grant-type:apikey"   --data-urlencode "apikey=${1}" https://iam.stage1.bluemix.net/identity/token
}


function cloudLogin {
    ic login -a https://cloud.ibm.com --sso
}

function changeTarget {
    echo "Usage changeTarget <switch -g or -r> <rg or region depending on switch>"
    ic target $1 $2
}

function changeAccount {
    ic target -c "$1"
}

function whoOwnsApiKey {
    echo "Usage: whoOwnsApiKey <clusterName or Id>"
    ic ks api-key info --cluster $1
}

function resetApiKey {
    echo "Usage: resetApiKey <region>"
    ic ks api-key reset --region $1
}

function getClusters {
    ic ks clusters
}

function clusterConfig {
    ic ks cluster config --cluster "$1" --admin
}

function attachObservabilityServiceConfig {
    echo "Usage: attachObservabilityServiceConfig logging [or monitoring] <clusterId or name> <instanceId or name>"

    ic ob $1 config create --cluster $2 --instance $3
}

function detachObservabilityServiceConfig {
    echo "Usage: detachObservabilityServiceConfig logging [or monitoring] <clusterId or name> <instanceId or name>"

    ic ob $1 config delete --cluster $2 --instance $3
}

function refreshMaster {
    echo "Usage: refreshMaster <clusterName>"
    ic ks cluster master refresh --cluster $1
}

function getSchematicsTemplateId {
    echo "Usage: getSchematicsTemplateId <workspaceId>"
    ic schematics workspace get --id $1
}

function createSchematicsWorkspace {
    echo "Usage: createSchematicsWorkspace <workspace.json> <stateFile>"
    ic schematics workspace new --file $1 --state $2
}

function pullSchematicsStateFile {
    echo "Usage: pullSchematicsStateFile <workspaceID> <templateId>"
    ic schematics state pull --id $1 --template $2
}
