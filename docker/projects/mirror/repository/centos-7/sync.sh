#!/bin/bash
REPO_DIR=/repository
REPOIDS="base extras updates"

date
/usr/bin/reposync --repoid=base --repoid=extras --repoid=updates --download_path=$REPO_DIR

for id in $REPOIDS; do
	mkdir -p $REPO_DIR/$id
	cd $REPO_DIR/$id
	echo here is $PWD
	date
	/usr/bin/createrepo --update -v $REPO_DIR/$id
done
