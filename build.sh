#!/bin/sh

# Script name script.sh
# Script for removing spool files from temporary directory

TMP_DIR="/tmp"
echo "Removing spool files from $TMP_DIR"
  
# Counting the number of spool files
files=`ls -l $TMP_DIR/<spool>* | wc -l` 

echo "There are total $files spool files in $TMP_DIR"

rm -rf $TMP_DIR/<spool>*

if [[ "$?" == "0" ]];then
    echo "All spool files successfully deleted"
else
    echo "Failed to delete spool files"
fi

# Counting the number of spool files
files=`ls -l $TMP_DIR/<spool>* | wc -l` 

echo "There are total $files spool files in $TMP_DIR directory"
echo " "

exit 0
