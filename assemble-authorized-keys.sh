#!/bin/sh

# limpar
echo "" > authorized_keys

echo "# General admin key" >> authorized_keys

cat admin-key.openssh.pub >> authorized_keys

echo "" >> authorized_keys
echo "# Backup Keys" >> authorized_keys

for f in `find host-keys/ -iname "*.pub"`   ; do
  HOST=$(basename $(dirname $f))
  CMDLINE="command=\"cd repos/$HOST;borg1 serve --append-only --restrict-to-path repos/$HOST\",no-port-forwarding,no-X11-forwarding,no-pty,no-agent-forwarding,no-user-rc"
  CHAVE=`cat $f`
  echo "$CMDLINE $CHAVE" >> authorized_keys
  echo "" >> authorized_keys
done

