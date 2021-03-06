#!/bin/bash

# From http://google.github.io/proto-lens/installing-protoc.html

TMPDIR=$(mktemp -d)

pushd $TMPDIR

PROTOC_ZIP=protoc-3.16.0-linux-x86_64.zip
curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.16.0/$PROTOC_ZIP
sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
sudo chmod -R 0755 /usr/local/bin/protoc /usr/local/include
rm -f $PROTOC_ZIP

popd
