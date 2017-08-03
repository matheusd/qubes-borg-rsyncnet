#!/bin/sh

# Make the necessary dirs
mkdir -p ~/.ssh/config.d
mkdir -p ~/bin

# Copy and assemble the ~/.ssh/config file
cp bakserver ~/.ssh/config.d
cat ~/.ssh/config.d/* > ~/.ssh/config

# Copy the borgbak utility script
cp borgbak ~/bin
chmod 700 ~/bin/borgbak

# Install the backup crontab
crontab bak.crontab
