#!/bin/sh

HOST=$1
if [[ -z "$HOST" ]] ; then
  echo "Provide the HOST."
  PROG=`basename $0`
  echo "Usage: $PROG HOST"
  exit 1
fi

DESTDIR=host-keys/$HOST
mkdir $DESTDIR

ssh-keygen \
  -t rsa \
  -f $DESTDIR/$HOST.openssh \
  -b 4096 \
  -C "chave-backup-$HOST" \
  -N ''

echo -n "Repo password: "
read -s PASS
echo ""
echo "Using pass $PASS"

export BORG_PASSPHRASE=$PASS
borg init --remote-path borg1 rsyncnet:repos/$HOST

cp template/* $DESTDIR
sed -i -- "s/\$HOST/$HOST.openssh/g" "$DESTDIR/bakserver"
sed -i -- "s/\$HOST/$HOST/g" "$DESTDIR/borgmatic.cfg"
sed -i -- "s/\$PASS/$PASS/g" "$DESTDIR/borgmatic.cfg"

echo -n $PASS > $DESTDIR/borgpass
echo -n $HOST > $DESTDIR/borgrepo
chmod 600 $DESTDIR/borgpass
chmod 600 $DESTDIR/borgrepo


