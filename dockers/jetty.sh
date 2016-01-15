#!/bin/bash
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v ~/myproject/git/work/TutorGroup/h2h-server/signalling/server/opt/jetty/jetty9/demo-base/:/var/lib/jetty/ \
  --env-file $SCRIPT_DIR/env.list \
  -h jetty \
  -p 80:8080 \
  -p 443:8443 \
  -d jetty
