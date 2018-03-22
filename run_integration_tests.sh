#!/bin/bash -ex

docker run --rm -d -p 80:80 -p 2100:2100/udp --name flutter_hse \
  gcr.io/hue-apps-ci-prod/hse-test-automation:23.3 \
  /bin/sh -c "/root/hse/hse.sh bridge1"
sleep 20

flutter test test_integration/bridge_client_test.dart

docker stop flutter_hse
