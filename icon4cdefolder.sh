#!/bin/bash

for foo in [ $(ls $1) ]
do
	icon4cde.sh $foo
done
