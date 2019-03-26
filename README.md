# 1. Install docker 

Follow the [Installation guide](https://docs.docker.com/install/linux/docker-ce/debian/#install-docker-ce-1). *(recommended)*

## 1.1. Installation version dated from 2019-02-13 (refer to the previous link)
```bash
 sudo apt-get update

 sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
```

## 1.2. Add Docker’s official GPG key:
```bash
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# check GPG key
sudo apt-key fingerprint 0EBFCD88

pub   4096R/0EBFCD88 2017-02-22
      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
uid                  Docker Release (CE deb) <docker@docker.com>
sub   4096R/F273FCD8 2017-02-22
```

## 1.3. Use the following command to set up the stable repository.
```bash
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

```

## 1.4. Install docker
```bash
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## 1.4. Configure Docker as non root user 


```bash
# create docker group it doesn't exist
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

*Log out and log back in so that your group membership is re-evaluated.*

For more information go to https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user


## 1.5. Enable docker service at startup
```bash
sudo systemctl enable docker
```

## 1.6. Configure Docker DNS which allows docker containers it to connect to internet

### 1.6.1 Get servver DNS configuration
#### 1.6.1.1. for ubuntu

Run the following command :

```bash
nmcli dev show | grep 'IP4.DNS'
```

The excepted result is above :

```bash
IP4.DNS[1]:                             147.99.0.248
IP4.DNS[2]:                             147.99.0.249
```

#### 1.6.1.2 for debian

```bash
more  /etc/resolv.conf
# Generated by NetworkManager
nameserver 138.102.210.7
nameserver 147.100.166.31
```

### 1.6.2. Connect with root account and set right docker DNS

```bash
sudo su
echo "{\"dns\": [\"YOUR_DNS_1_IP_HERE\", \"YOUR_DNS_2_IP_HERE\"]}" > /etc/docker/daemon.json
```

- daemon.json file content example :

```json
{
  "dns": ["147.99.0.222", "147.99.0.223"]
}
```

## 1.6.3. restart docker and from root:

```bash
service docker restart
```

# 2. Run docker container

## 2.1 Build docker image
```bash
docker build --no-cache https://github.com/OpenSILEX/opensilex-opencpu-docker.git -t opensilex/opencpu
```

## 2.2 Run docker image
- example :
```bash
docker run -d -t -p 8004:8004  --name=opensilex-ocpu opensilex/opencpu:latest
# or
# if you want to link a host folder and container folder
# docker run -v {host_scripts_path}:/home/opencpu/scripts --name opencpu-server -t -p 8004:8004 opencpu/rstudio
```
# 3. How to install an openCPU application

You can connect to the ```http://{serverIp}:8004/rstudio``` your favorite R IDE

The default password is __opencpu__ but it can be modified. (coming soon ...)

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


# 4. How to move an R package from host to container {host_scripts_path} and install it

## 4.1 From github account (recommended way)

You can connect to the ```http://{serverIp}:8004/rstudio``` your favorite R IDE

The default password is __opencpu__ but it can be modified. (coming soon ...)

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

<!-- ## 4.1 From local directory inside the container (See 3.2 step comments before)
If you have set a link between ```{host_scripts_path}``` and ```/home/opencpu/scripts```.
You can move your archive in ```{host_scripts_path}``` in order to be able to access
it in the container.

Now can connect to the docker container and install your package :
```bash
docker exec -i -t container_name /bin/bash
# switch to non root user
su opencpu
# install package
R -e 'install.packages("/home/opencpu/scripts/webapp_0.1.1.tar.gz",repos=NULL,type ="source")'
``` -->

# To uninstall docker : 
Follow instructions at :

``` https://docs.docker.com/install/linux/docker-ce/debian/#uninstall-docker-ce```
