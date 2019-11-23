#!/bin/zsh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd "$SCRIPTPATH"

h2h-dependecies/KMSFilter/SubtitlesFilter-31Aug2016/jar/1.5.0-SNAPSHOT/install.sh \
    && h2h-dependecies/KMSFilter/speex/install.sh \
    && mvn -Dmaven.test.skip=true clean install -f appserver/h2h-app-server/server/core/pom.xml \
    && mvn -Dmaven.test.skip=true clean install -f appserver/h2h-app-server/server/extensions/xep0045-muc/pom.xml \
    && mvn -Dmaven.test.skip=true clean install -f appserver/h2h-app-server/server/extensions/websockets/pom.xml \
    && mvn -Dmaven.test.skip=true clean install -f appserver/h2h-app-server/examples/embedded-war/pom.xml

if [ $? -ne 0 ]
then
    ~/loadrc/gitrc/gbib.sh
else
    ~/loadrc/gitrc/gbig.sh
fi
