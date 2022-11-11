#!/bin/bash

REPOS=contrib non-free

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -r -i 's/^deb(.*)$/deb\1 ${REPOS}/g' /etc/apt/sources.list