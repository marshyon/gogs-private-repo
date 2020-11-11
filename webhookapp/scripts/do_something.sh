#!/bin/bash

CURRDIR=`pwd`
WORKDIR="scripts"
REPO="<name of repo to be backed up>"
cd "${CURRDIR}/${WORKDIR}"

if [ ! -d  $REPO ]
then
    echo " :: ${REPO} repository not found, checking it out ..."
    git clone http://<API TOKEN FROM GOGS>@<DOCKER SERVER>:3333/<USER>/${REPO}.git
else 
    cd $REPO
    git pull http://<API TOKEN FROM GOGS>@<DOCKER SERVER>:3333/<USER>/${REPO}.git
fi
