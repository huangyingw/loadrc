#!/bin/bash
docker rm docker-jetty
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/webapps/:/opt/jetty/webapps/ \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/logs/:/opt/jetty/logs/ \
  --env-file $SCRIPT_DIR/env.list \
  -h docker-jetty \
  --name docker-jetty \
  -p 80:8080 \
  -p 443:8443 \
  -d docker-jetty
