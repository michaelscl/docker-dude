#!/bin/bash

sudo docker stop dude
sudo docker rm dude

sudo docker rmi dude
sudo docker build -t dude --no-cache=false .

