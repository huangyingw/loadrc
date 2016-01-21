#!/bin/bash
SCRIPT_DIR=$(dirname $0)
docker run  \
  -v /Users/huangyingw/myproject/git/work/TutorGroup/service/:/root/service/ \
  --env-file $SCRIPT_DIR/env.list \
  -h kurento \
  -p 8888:8888 \
  -p 8089:8089 \
  -d java /bin/sh -c "java -Dkms.ws.uri=ws://52.33.62.122:8888/kurento -Dapp.server.url=http://52.3475.3:8089/ -Dserver.port=8089 -jar /root/service/lib/tutorgroup-group-call.jar &>/dev/null &"
