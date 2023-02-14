#!/bin/bash

/bin/createusers.py
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

service ssh start
jupyterhub --Spawner.default_url=/lab -f /etc/jupyterhub_config.py

