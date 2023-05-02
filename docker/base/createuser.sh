#!/bin/bash

uid=$1
user=$2
pw=$3

adduser --disabled-password --gecos '' --uid $uid $user
usermod --password $(echo $pw | openssl passwd -1 -stdin) $user
usermod -aG sudo $user
usermod --shell /usr/bin/bash $user
