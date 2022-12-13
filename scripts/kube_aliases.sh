#################################################################################
# Cloud and Kube Conviniences
#################################################################################
alias kc="kubectl"
alias kck="kc krew"
alias kcc="kc ctx"
alias kcns="kc ns"
alias kcd="kc delete"
alias kcg="kc get"
alias kcGetAllFromAll="kcg all --all-namespaces"
alias kcl="kc logs" # logs for what after a space
alias kcx="kc exec -it "
alias kcdes="kc describe"
alias kcGetContexts="kc config get-contexts"
alias kcCurrContext="kc config current-context"
alias whichCluster="kc cluster-info; kcCurrContext"

function kcSetContextAndNs {
    echo "Set kc to a particular context and namespace"
    read "ns?Enter namespace: "

    kc config set-context --current --namespace=$ns
}

function kcCreate {
    read "item?What do you want kubectl to create?: "
    read "itemName?What is it's name?: "

    kc create "$item" $itemName
}

function kcGetResourceFromNs {
    echo "To get all resources from a ns, use `all`"
    read "resource?What resource do you want kc to get?: "
    read "namespace?Which ns?: "

    kcg $resource -n $namespace
}

function kcExplain {
    echo "Usage: kcExplain resource[.field];  add --recursive to get the entire set of fields"

    kc explain $1 | less
}

function kcGetCustomOutput {
    echo "Usage: kcGetCustomOutput <resourceName> <columnHeading>:<jsonPath>[,<columnHeading>:<jsonPath>]"
    echo "eg: kcg po -o custom-cloumns=NAME:metadata.name,NODE:spec.nodeName"

    read "resource?Which resource? "
    read "jsonPath?jsonPath? "
    read "ns?Which ns? "

    kcg $resource -n $ns -o custom-columns=$jsonPath
}

function portForward {
    echo "portForward <svc> <port> localPort:appPort"
    echo "ex: portForward svc/druid-router 8888 &"

    kc port-forward  "$1" "$2" &
}

function execPod {
    echo "execPod <podName>; if container, --container <contianerNaem>"
    kcx $1 -- /bin/bash
}
