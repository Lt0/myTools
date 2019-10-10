#!/bin/bash

docker run --rm --net=host -v /vob:/vob -it theia yarn theia start /vob --hostname=0.0.0.0 --port 3333
