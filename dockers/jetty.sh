#!/bin/bash
docker rm jetty
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/jetty/jetty9/demo-base/webapps/:/var/lib/jetty/webapps/ \
  --env-file $SCRIPT_DIR/env.list \
  -h jetty \
  --name jetty \
  -p 80:8080 \
  -p 443:8443 \
  -d jetty
