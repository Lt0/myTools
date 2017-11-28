#!/bin/sh
nmbd &
smbd -F &
/bin/sh
