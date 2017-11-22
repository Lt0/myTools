#!/bin/sh
nmbd &
smbd -F &
/bin/bash
