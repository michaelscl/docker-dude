#!/bin/bash

sudo docker run -it --name dude \
  -p 2211:2211 -p 2210:2210 \
  --volume /etc/localtime:/etc/localtime:ro \
  --health-cmd /healthcheck.sh --health-start-period 3s --health-interval 1m --health-timeout 1s --health-retries 3 \
  --log-opt max-size=10m --log-opt max-file=5 \
  dude