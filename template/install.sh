#!/bin/sh
mkdir -p ~/.ssh/config.d
cp bakserver ~/.ssh/config.d
cat ~/.ssh/config.d/* > ~/.ssh/config
mkdir -p ~/bin
cp borgbak ~/bin
chmod 700 ~/bin/borgbak

crontab bak.crontab
