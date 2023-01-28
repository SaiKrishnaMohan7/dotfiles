####################################################################################
# DOCKER ALIASES
####################################################################################

# Starts and stop the docker daemon as a service
# all docker commands have to be used as root since the docker daemon binds to the UNIX socket (owned by root user)
# https://docs.docker.com/engine/install/linux-postinstall/ There are some security implications here to be aware of
# alias sdstr= "sudo service docker start"
# alias sdstp= "sudo service docker stop"

#This is linux specific not used for Mac
alias dkd="docker-compose down -v"