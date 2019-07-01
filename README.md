This readme allows you to install a docker image of openCPU which contains
a demonstration [R web application](https://www.opencpu.org/apps.html) and the latest version of phisWSClientR package.

``Prerequisites`` :

- Access to root account
- Able to use the 8004

<!-- TOC -->

- [1. Install automatically container with ``install-docker-ocpu.sh`` script](#1-Install-automatically-container-with-install-docker-ocpush-script)
  - [1.1 Install docker if not installed (installation documentation date : 2019-06-14)](#11-Install-docker-if-not-installed-installation-documentation-date--2019-06-14)
  - [1.2 Configure docker for opencpu](#12-Configure-docker-for-opencpu)
  - [1.3 Log out and reconnect to your account](#13-Log-out-and-reconnect-to-your-account)
  - [1.4 install opencpu docker](#14-install-opencpu-docker)
  - [1.5 ``(Optional)`` configure docker DNS](#15-Optional-configure-docker-DNS)
- [2. Install manually the opensilex opencpu container (If docker is already installed go to step 2.4)](#2-Install-manually-the-opensilex-opencpu-container-If-docker-is-already-installed-go-to-step-24)
  - [2.1. Installation version dated from 2019-02-13 (refer to the previous link)](#21-Installation-version-dated-from-2019-02-13-refer-to-the-previous-link)
  - [2.2. Add Docker’s official GPG key:](#22-Add-Dockers-official-GPG-key)
  - [2.3. Use the following command to set up the stable repository.](#23-Use-the-following-command-to-set-up-the-stable-repository)
  - [2.4. Install docker](#24-Install-docker)
  - [2.5. Configure Docker as non root user](#25-Configure-Docker-as-non-root-user)
  - [2.6. Enable docker service at startup](#26-Enable-docker-service-at-startup)
  - [2.7. (Optional) Configure Docker DNS which allows docker containers it to connect to internet (Only if you have issue with DNS)](#27-Optional-Configure-Docker-DNS-which-allows-docker-containers-it-to-connect-to-internet-Only-if-you-have-issue-with-DNS)
    - [2.7.1. Get servver DNS configuration](#271-Get-servver-DNS-configuration)
      - [2.7.1.1. for ubuntu](#2711-for-ubuntu)
      - [2.7.1.2. for debian](#2712-for-debian)
      - [2.7.1.3. Set right docker DNS (Informtations about DNS configuration))](#2713-Set-right-docker-DNS-Informtations-about-DNS-configuration)
      - [2.7.1.4. Specific step for Ubuntu system (network configuration)](#2714-Specific-step-for-Ubuntu-system-network-configuration)
      - [2.7.1.5. Step for Ubuntu or Debian system (docker dns configuration)](#2715-Step-for-Ubuntu-or-Debian-system-docker-dns-configuration)
      - [2.7.1.6. restart docker and from root:](#2716-restart-docker-and-from-root)
- [3. Run docker container](#3-Run-docker-container)
  - [3.1. Build docker image](#31-Build-docker-image)
  - [3.2. Run docker image](#32-Run-docker-image)
  - [3.3. Test demo application](#33-Test-demo-application)
  - [3.4. Stop docker container](#34-Stop-docker-container)
  - [3.5. Start docker container](#35-Start-docker-container)
  - [3.6. Remove docker container](#36-Remove-docker-container)
- [4. How to install a custom openCPU application](#4-How-to-install-a-custom-openCPU-application)
- [5. How to move an R package from host to container {host_scripts_path} and install it](#5-How-to-move-an-R-package-from-host-to-container-hostscriptspath-and-install-it)
  - [5.1. From github account (recommended way)](#51-From-github-account-recommended-way)
  - [5.2. From local directory inside the container (See 3.2 step comments before)](#52-From-local-directory-inside-the-container-See-32-step-comments-before)
- [6. To uninstall docker :](#6-To-uninstall-docker)

<!-- /TOC -->


# 1. Install automatically container with ``install-docker-ocpu.sh`` script

<details><summary>Click here to see the steps to install configure docker and install container with <em>install-docker-ocpu.sh</em> script</summary>

This script allow you to install easily docker, configure it for your purpose and install opensilex opencpu docker.

```
 Usage: install-docker-ocpu.sh [ 
          Usage: install-docker-ocpu.sh [ 
            [-i --install-all docker-rstudio-password]  regroup all other functions
            [-d --install-docker ] For Ubuntu and Debian - installation documentation date : 2019-06-14
            [-c --configure-docker] For Ubuntu and Debian  
            [-u --docker-dns-reconfigure] For Ubuntu and Debian 
            [-n --configure-network] # add 172.17.0.1 to dnsmasq for Ubuntu only
            [-o --install-ocpu-docker-with-password docker-rstudio-password] For Ubuntu and Debian
            [-h --help]
          ]
```
Three steps are needed to install and run this docker container :

## 1.1 Install docker if not installed (installation documentation date : 2019-06-14)
   ``It is better to install docker from the `` [official documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
```bash
  . install-docker-ocpu.sh -d 
```

## 1.2 Configure docker for opencpu
```bash
  . install-docker-ocpu.sh -c 
```

## 1.3 Log out and reconnect to your account

## 1.4 install opencpu docker
```bash
  . install-docker-ocpu.sh -o {password for rstudio}
```
Example :  . install-docker-ocpu.sh -o secret

``If you have some issues with internet connection configuration (DNS server). You can use these following commands.``
## 1.5 ``(Optional)`` configure docker DNS
```bash
  . install-docker-ocpu.sh -u 
```

If the container is successfully installed, go to the step 3.3 .

</details>

# 2. Install manually the opensilex opencpu container (If docker is already installed go to step 2.4)

<details><summary> Click here to see steps to install manually docker opencpu</summary>

Follow the [Installation guide](https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1). _(recommended)_

## 2.1. Installation version dated from 2019-02-13 (refer to the previous link)

```bash
 sudo apt-get update

 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
```

## 2.2. Add Docker’s official GPG key:

```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# check GPG key
sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2027-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```

## 2.3. Use the following command to set up the stable repository.

```bash
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

```

## 2.4. Install docker

```bash
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## 2.5. Configure Docker as non root user

```bash
# create docker group if it doesn't exist
sudo groupadd docker
```

```bash
# put phis user in  docker group
user=phis
sudo usermod -aG docker $user
# $USER means the connected user
# if is different from phis user run the following commands
# sudo usermod -aG docker $USER
```

_Log out and log back in so that your group membership is re-evaluated._
or use :

```bash
newgrp docker
```

For more information go to https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user

## 2.6. Enable docker service at startup

```bash
sudo systemctl enable docker
```

## 2.7. (Optional) Configure Docker DNS which allows docker containers it to connect to internet (Only if you have issue with DNS)

### 2.7.1. Get servver DNS configuration

#### 2.7.1.1. for ubuntu

Run the following command :

```bash
nmcli dev show | grep 'IP4.DNS'
```

The excepted result is above :

```bash
IP4.DNS[1]:                             147.99.0.248
IP4.DNS[2]:                             147.99.0.249
```

#### 2.7.1.2. for debian

```bash
more  /etc/resolv.conf
# Generated by NetworkManager
nameserver 138.102.210.7
nameserver 147.100.166.31
```

#### 2.7.1.3. Set right docker DNS ([Informtations about DNS configuration]([https://link](https://stackoverflow.com/questions/49998099/dns-not-working-within-docker-containers-when-host-uses-dnsmasq-and-googles-dns/50001940#50001940)))

#### 2.7.1.4. Specific step for Ubuntu system (network configuration)
```bash
#A clean solution is to configure docker+dnsmasq so than DNS #requests from the docker container are forwarded to the dnsmasq #daemon running on the host.

#For that, you need to configure dnsmasq to listen to the network #interface used by docker, by adding a file /etc/NetworkManager/#dnsmasq.d/docker-bridge.conf:

sudo touch /etc/NetworkManager/dnsmasq.d/docker-bridge.conf

echo "listen-address=172.17.0.1" > /etc/NetworkManager/dnsmasq.d/docker-bridge.conf

sudo service network-manager restart
```

#### 2.7.1.5. Step for Ubuntu or Debian system (docker dns configuration)

```bash
#You can add 172.17.0.1, i.e. the host's IP #address from within docker, to the list of DNS servers in docker's configuration file.

echo "{\"dns\": [\"172.17.0.1\",\"YOUR_DNS_1_IP_HERE\", \"YOUR_DNS_2_IP_HERE\", \"OTHER_DNS_IP_HERE\",....]}" > /etc/docker/daemon.json
```

- **daemon.json file content** example :

```json
{
  "dns": ["172.17.0.1","147.100.116.5", "147.100.126.4"]
}
```

#### 2.7.1.6. restart docker and from root:

```bash
service docker restart
```
</details>

# 3. Run docker container

## 3.1. Build docker image

``docker build --no-cache {repository or local directory} -t opensilex/opencpu``

```bash
docker build --no-cache https://github.com/OpenSILEX/opensilex-opencpu-docker.git -t opensilex/opencpu
```

## 3.2. Run docker image

- example :

```bash
docker run -d -t -p 8004:8004 -e USER_PASSWORD=secret --name=opensilex-ocpu opensilex/opencpu:latest
# or
# if you want to link a host folder and container folder
# docker run -v {host_scripts_path}:/home/opencpu/scripts --name opencpu-server -t -p 8004:8004 opencpu/rstudio
```

`By default, the docker file already contains "opensilex/opensilex-datavis-rapp-demo" application and "phisWSClientR" package.`

## 3.3. Test demo application

You can now go to : http://localhost:8004/ocpu/apps/opensilex/opensilex-datavis-rapp-demo/www/ .

You will able to try the demo R application.

## 3.4. Stop docker container
Run in terminal : 
```
docker stop opensilex-ocpu
```

## 3.5. Start docker container
Run in terminal : 
```
docker start opensilex-ocpu
```

## 3.6. Remove docker container
Run in terminal : 
```
docker stop opensilex-ocpu
docker rm opensilex-ocpu
```

# 4. How to install a custom openCPU application

You can connect to the `http://{serverIp}:8004/rstudio` your favorite R IDE

The default password is **opencpu** but it can be modified. (coming soon ...)

And run this command

```bash
opencpu::install_apps("opensilex/opensilex-datavis-rapp-demo")
```

or you can connect to the docker container :

```bash
docker exec -i -t container_name /bin/bash
# switch to non root user
su opencpu
# install package
R -e 'opencpu::install_apps("opensilex/opensilex-datavis-rapp-demo")'
```


# 5. How to move an R package from host to container {host_scripts_path} and install it
<details><summary>Click here to see steps to move an R package from host to container</summary>

## 5.1. From github account (recommended way)

You can connect to the `http://{serverIp}:8005/rstudio` your favorite R IDE

The default password is **opencpu** but it can be modified. (coming soon ...)

And run this command

```R
remotes::install_github("openSILEX/phisWSClientR", build_vignettes=TRUE, ref="v1.3.0", upgrade ="always")
```

or you can connect to the docker container :

```bash
docker exec -i -t container_name /bin/bash
# switch to non root user
su opencpu
# install package
R -e 'remotes::install_github("openSILEX/phisWSClientR", build_vignettes=TRUE,ref="v1.3.0",upgrade ="always")'
```

## 5.2. From local directory inside the container (See 3.2 step comments before)

If you have set a link between `{host_scripts_path}` and `/home/opencpu/scripts`.
You can move your R package archive (tar.gz) in `{host_scripts_path}` in order to be able to access
it in the container.

Now can connect to the docker container and install your package from the source :

```bash
docker exec -i -t container_name /bin/bash
# switch to non root user
su opencpu
# install package
R -e 'install.packages("/home/opencpu/scripts/phisWSClientR_1.3.0.tar.gz",repos=NULL,type ="source")'
```

# 6. To uninstall docker :

Follow instructions at :

``https://docs.docker.com/install/linux/docker-ce/debian/#uninstall-docker-ce``
</details>