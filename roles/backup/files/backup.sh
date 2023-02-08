#! /usr/bin/env bash
[[ $- == *i*  ]] || set -eu -o pipefail

function usage () {
    echo "Usage :  $0 [h] [-c BACKUPCOUNT] [-l LINK-DEST] [--]

    Options:
    -h|help         Display this message
    -c              Set count of backup
    -l              pass this as link-dest to rsync"
}

HOST=$(hostname)
RSYNC="rsync -v -avPhxc --ignore-errors --delete-excluded --delete --exclude-from exclude.txt"
SHORTNAME=home
FOLDER=/home/guserav/
SHORTNAME=pictures
FOLDER=/var/data/
LINK_DEST=""
while getopts ":hc:l:" opt
do
  case $opt in
    h ) usage;
        exit 0
        ;;

    l ) LINK_DEST=$OPTARG
        ;;

    * ) echo -e "\n  Option does not exist or requires an argument: $OPTARG\n"
        usage;
        exit 1
        ;;
  esac
done
shift $((OPTIND-1))

BACKUP_DIR=jackson:/backup/$HOST-$SHORTNAME-`date "+%Y.%m.%d"`

if [ -z "$LINK_DEST" ]
then
    true
else
    RSYNC="$RSYNC --link-dest=$LINK_DEST"
fi

RSYNC="$RSYNC $FOLDER $BACKUP_DIR"

echo $RSYNC

read -r -n1 -p "Run? [y/N]: " confirm
echo ""
if [ "$confirm" != "y" ]
then
    echo "OK! Aborting"
    exit
fi

$RSYNC
