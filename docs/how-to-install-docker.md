# Docker 1.11.2 Installation Guide

## Prerequisites
* Linux(Ubuntu is recommended)

## Installation Guide
1. Make sure you don't have docker installed. If you do, you can remove docker on Ubuntu by executing:
  ```bash
  sudo apt-get purge docker-ce
  sudo mv /var/lib/docker /var/lib/docker-old
  ```
2. Download and extract docker archive files
  ```bash
  wget https://get.docker.com/builds/Linux/x86_64/docker-1.11.2.tgz /tmp
  cd /tmp; tar xvf docker-1.11.2.tgz
  ```
3. Move docker executable files to system executable path
  ```bash
  sudo mv docker/* /usr/bin
  ```
4. Create docker directory
  ```bash
  sudo mkdir /var/lib/docker
  ```
5. Run the docker daemon
  ```bash
  sudo docker daemon --insecure-registry=registry.cn-north-1.hwclouds.com
  ```

The installation of docker has finished. You are free to use `docker` now.