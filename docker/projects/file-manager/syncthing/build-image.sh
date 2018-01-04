#!/bin/bash


IMAGE_NAME="syncthing"

SUFFIX=".tar.gz"
DIR="pkg"
BIN="syncthing"
PKG_NAME=$(ls $DIR/)
DIR_NAME=$(basename $PKG_NAME $SUFFIX)

tar -C $DIR -zxvf $DIR/$PKG_NAME $DIR_NAME/$BIN
mv $DIR/$DIR_NAME/$BIN $DIR/
echo $DIR/$DIR_NAME

rm -rv $DIR/$DIR_NAME

docker build -t $IMAGE_NAME .
rm -v $DIR/$BIN
