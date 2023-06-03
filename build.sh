#!/bin/sh

if [ ! -d ~/barelab/$1 ];
then
	mkdir ~/barelab/$1
	mkdir /var/www/build.barelab.com/barelab/logs/$1
else
	echo "team directory $1 found"
fi

if [ ! -d ~/barelab/$1/$2 ];
then
	mkdir ~/barelab/$1/$2
else
	echo "project directory $2 found"
fi

if [ ! -d ~/barelab/$1/$2/$3 ];
then
	cd ~/barelab/$1/$2
    echo "git clone git@github.com:InstantPost/$3.git"
	git clone git@github.com:InstantPost/$3.git
	mkdir /var/www/build.barelab.com/barelab/logs/$1/$2/$3
	mkdir /var/www/build.barelab.com/barelab/logs/$1/$2/$3-dev
else
	echo "repo directory $3 found"
fi

if [ ! -d /var/www/build.barelab.com/barelab/logs/$1/$2/$3 ];
then
	mkdir -p /var/www/build.barelab.com/barelab/logs/$1/$2/$3
	mkdir -p /var/www/build.barelab.com/barelab/logs/$1/$2/$3-dev
else
	echo "project log directory $2 found"
fi

if [ -d ~/barelab/$1/$2/$3 ];
then
	cd ~/barelab/$1/$2/$3
	git $4 $5
else
	echo ~/barelab/$1/$2/$3
	echo "unable to pull from remote"
fi

echo "Checking for extra build files..."

if [ -e ~/barelab/$1/$2/$3.sh ];
then
	echo "Executing extra build file at ~/barelab/$1/$2/$3.sh"
	UUID=$(uuid)
	echo $UUID
        ~/barelab/$1/$2/$3.sh $1 $2 $3 > /var/www/build.barelab.com/barelab/logs/$1/$2/$3/$UUID.log 2>&1 &
else
	echo "No extra build file found at ~/barelab/$1/$2/$3.sh"
fi

if [ -d ~/barelab/$1/$2/$3-dev ];
then
	cd ~/barelab/$1/$2/$3-dev
	git $4 $5
else
	echo "unable to pull from remote"
fi

echo "Checking for extra build files..."

if [ -e ~/barelab/$1/$2/$3-dev.sh ];
then
	echo "Executing extra build file at ~/barelab/$1/$2/$3-dev.sh"
	UUID=$(uuid)
	echo $UUID
        ~/barelab/$1/$2/$3-dev.sh $1 $2 $3-dev > /var/www/build.barelab.com/barelab/logs/$1/$2/$3-dev/$UUID.log 2>&1 &
else
	echo "No extra build file found at ~/barelab/$1/$2/$3-dev.sh"
fi

echo " "
echo " "

exit 0
