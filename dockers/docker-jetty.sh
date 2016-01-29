#!/bin/bash
docker stop docker-jetty
docker rm docker-jetty
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/webapps/:/opt/jetty/webapps/ \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/logs/:/opt/jetty/logs/ \
  -v /Users/huangyingw/myproject/git/tools/jetty-distribution-9.3.6.v20151106/resources/log4j.properties:/opt/jetty/resources/log4j.properties \
  --env-file $SCRIPT_DIR/env.list \
  -h docker-jetty \
  --name docker-jetty \
  -p 80:8080 \
  -p 443:8443 \
  -d docker-jetty
