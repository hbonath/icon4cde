#!/bin/bash

# script to use imagemagick to convert any image file to an icon for use with CDE
# July 2013 Henry Bonath (henry@thebonaths.com)

CONVERT=$(which convert)
IDENTIFY=$(which identify)
BASENAME=$(basename $1)
BASEFILE=${BASENAME%%.*}
OUTFILE=$BASEFILE.xpm
ICONSPATH=$HOME/.dt/icons

# check for imagemagick
if [ $CONVERT ] && [ $IDENTIFY ]; then
	#imagemagick exists! hooray! Next we need to check if the proper input file was specified...
	#echo "DEBUG: Imagemagick is installed"
	if [ $# -eq 0 ]; then
		echo "Usage: $0 /path/to/input/file.png"
		#echo "DEBUG: CONVERT=$CONVERT"
		#echo "DEBUG: IDENTIFY=$IDENTIFY"
		exit 2
	  else
		if [ -d $ICONSPATH ]; then		
			# we get to work!
			#echo "DEBUG: 3 checks passed, Executing $0 $1"
			#echo "DEBUG: BASENAME=$BASENAME"
			#echo "DEBUG: BASEFILE=$BASEFILE"
			$CONVERT $1 -resize '48x48' /tmp/$OUTFILE
			mv /tmp/$OUTFILE $ICONSPATH/$BASEFILE.l.pm
			$CONVERT $1 -resize '32x32' /tmp/$OUTFILE
			mv /tmp/$OUTFILE $ICONSPATH/$BASEFILE.m.pm
			$CONVERT $1 -resize '16x16' /tmp/$OUTFILE
			mv /tmp/$OUTFILE $ICONSPATH/$BASEFILE.t.pm
			echo "Converted $1 to `ls -d $ICONSPATH/$BASEFILE.*`"
			exit 0
		else
			echo "$HOME/.dt/icons not found, is CDE installed on your system?"
			exit 3
		fi		
	fi
	
else
	#imagemagick does not exist - boo!
	#echo "DEBUG: ImageMagick Not Installed"
	echo "ImageMagick does not seem to be installed or is not in your PATH"
	exit 1
fi
exit 0
