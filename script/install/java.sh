#!/bin/bash

source ./install/util.sh

JAVA_VERSION=${1:-"21"}

JAVA_FILE="jdk-${JAVA_VERSION}_linux-x64_bin.deb"
JAVA_FILE_SHA256SUM="jdk-${JAVA_VERSION}_linux-x64_bin.deb.sha256"


echo "Initiating Java $JAVA_VERSION Oracle installation..."

curl -L https://download.oracle.com/java/$JAVA_VERSION/latest/$JAVA_FILE -o ./download/$JAVA_FILE

curl -L https://download.oracle.com/java/$JAVA_VERSION/latest/$JAVA_FILE_SHA256SUM -o ./download/$JAVA_FILE_SHA256SUM

if SHA256SUM_ISVALID $JAVA_FILE $JAVA_FILE_SHA256SUM ;then
    dpkg -i ./download/$JAVA_FILE
    echo "Java $JAVA_VERSION Oracle has been successfully installed."
else
    echo "Installation of Java $JAVA_VERSION Oracle has failed." >&2
    exit 1
fi


