#!/bin/bash

# /*
#  * ******************************************************************************
#  *                                     install-docker-ocpu.sh
#  *  opensilex-ocpu-docker
#  *  Copyright © INRA 2019
#  *  Creation date:  12 June, 2019
#  *  Contact: arnaud.charleroy@inra.fr
#  * ******************************************************************************
#  */

# This script allows to install docker, configure docker for the user which launch this script,
# install opensilex opencpu docker with a custom password for rstudio server included in. 


# get distribution
linuxDistribution=$(cat /etc/issue)

# define the different functions availables
usage()
{
    echo "Description : install docker configure it for the current user and install opencpu docker"
    echo "Required dependencies on Debian : sudo (apt-get install sudo)"
    echo "Usage: install-docker-ocpu.sh [ 
            [-i --install-all docker-rstudio-password]  regroup all other functions
            [-d --install-docker ] For Ubuntu and Debian - installation doc date : 14/06/2019
            [-c --configure-docker] For Ubuntu and Debian  
            [-u --docker-dns-reconfigure] For Ubuntu and Debian 
            [-n --configure-network] # add 172.17.0.1 to dnsmasq for Ubuntu only
            [-o --install-ocpu-docker-with-password docker-rstudio-password] For Ubuntu and Debian
            [-h --help]
          ]"
    echo "Example : install-docker-ocpu"
    
}

# message formatting 
info_message(){
    message=$1
    echo -e "\033[32m${message}\033[0m"
}

# install docker (installation doc date 14/06/2019)
install_docker()
{
    info_message "Installation docker" 
    # check distribution 
    if [[ $linuxDistribution != *"Debian"* && $linuxDistribution != *"Ubuntu"* ]]; then 
        echo "Linux version not supported (only Debian or Ubuntu)"
        exit 1

        else
        sudo apt-get update

        sudo apt-get install \
            apt-transport-https \
            ca-certificates \
            curl \
            gnupg2 \
            software-properties-common -y
        
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

        sudo apt-key fingerprint 0EBFCD88

        sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/debian \
            $(lsb_release -cs) \
            stable"

        sudo apt-get update

        sudo apt-get install docker-ce docker-ce-cli containerd.io -y
    fi
}

# create docker group and add user to docker user group
configure_docker(){
    if ! [[ $(getent group docker) ]]; then
        sudo groupadd docker
    fi
    # restart docker
      # more information at https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user
    if [[ $linuxDistribution == *"Debian"* ]]; then 
        sudo usermod -aG docker $(whoami)
        sudo service docker start
    fi

    if [[ $linuxDistribution == *"Ubuntu"* ]]; then 
        sudo usermod -aG docker $USER
        sudo systemctl restart docker
    fi
}

# configure docker dns for a computer
configure_docker_daemon()
{
    info_message "Configure docker daemon" 

    # check distribution and get server dns address
    if [[ $linuxDistribution == *"Debian"* ]]; then 
        rawIpAddress=$(more  /etc/resolv.conf| grep -o "nameserver .*" |  sed "s/^nameserver//"| sed -e 's/^[ \t]*//')
    fi

    if [[ $linuxDistribution == *"Ubuntu"* ]]; then 
        rawIpAddress=$(nmcli dev show | grep 'IP4.DNS' | sed 's/.*IP4.DNS...: \(.*\)/\1/' | sed -e 's/^[ \t]*//')
    fi
    # create adress array
    ipAddress=$(echo $rawIpAddress | tr ";" "\n")

    #create docker daemon config file
    dockerDaemonConfig="{\"dns\": [\"172.17.0.1\""

    for addr in $ipAddress
    do
        dockerDaemonConfig="$dockerDaemonConfig, \"$addr\""
    done

    dockerDaemonConfig="$dockerDaemonConfig]}"

    if [ -f /etc/docker/daemon.json ]; then
       sudo mv /etc/docker/daemon.json /etc/docker/daemon.json.bak
    fi
    sudo touch  /etc/docker/daemon.json

    info_message "Configure /etc/docker/daemon.json with computer DNS"
    echo $dockerDaemonConfig | sudo  tee -a /etc/docker/daemon.json  > /dev/null

    info_message "Reload docker service"
    sudo service docker restart
}

configure_network(){
    info_message "Configure network" 
    if [[ $linuxDistribution == *"Ubuntu"* ]]; then 
        if [ ! -f /etc/NetworkManager/dnsmasq.d/docker-bridge.conf ]; then
            sudo touch /etc/NetworkManager/dnsmasq.d/docker-bridge.conf
        fi

        # default docker within gateway
        sudo echo "listen-address=172.17.0.1" > /etc/NetworkManager/dnsmasq.d/docker-bridge.conf

        sudo service network-manager restart
    fi
}

# install opensilex opencpu docker 
install_ocpu()
{
    info_message "Installation docker opensilex ocpu" 
    # create docker image
    docker build --no-cache https://github.com/OpenSILEX/opensilex-opencpu-docker.git -t opensilex/opencpu

    # run docker image locally
    if [ -z "$userpassword" ]
        then
            docker run -d -t -p 8004:8004 --name=opensilex-ocpu opensilex/opencpu:latest
        else
            docker run -d -t -p 8004:8004 -e USER_PASSWORD=$userpassword --name=opensilex-ocpu opensilex/opencpu:latest
    fi
  
}


# configure docker environment
configure_docker_environment()
{
    info_message "Configure docker for $(whoami) user." 
    configure_docker

    info_message "You need to log off and login before launch the last step `install_ocpu`" 
}

install_all()
{
    install_docker
    configure_docker_environment
    install_ocpu
}

if [ "$1" == "" ]; then
    usage
    else
    while [ "$1" != "" ]; do
        case $1 in
            -d | --install-configure-all ) shift
                                install_all  
                                userpassword=$1
                                ;;
            -d | --install-docker ) install_docker
                                ;;
            -c | --configure-docker ) configure_docker_environment
                                ;;
            -u | --docker-dns-reconfigure ) configure_docker_daemon
                                ;;
            -n | --configure-network ) configure_network
                                ;;
            -o | --install-ocpu-docker-with-password ) shift 
                                userpassword=$1
                                install_ocpu
                                ;;
            -h | --help )       usage
                                ;;
            * )                 usage
        esac
        shift
    done
fi

    


