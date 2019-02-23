#!/bin/bash

tar cv --files-from /dev/null | docker import - scratch
