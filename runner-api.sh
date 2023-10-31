#!/bin/sh

#mkdir target && chown -R jenkins:jenkins target && chmod -R ug+rwx target

echo "Run automated API tests (using runner script)..."
#mvn -f pom.xml test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
mvn test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
#mvn test -Dcucumber.filter.tags=$TYPE
echo "API tests run completed..."

#version 2 - copy target from container to host
echo "Check permissions in runner"
ls -lrt
whoami
cd target/
ls -lrt
echo "Current workspace is $WORKSPACE"

#install docker
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin --no-install-recommends

echo 'Copy target from docker container to workspace'
docker cp api-test-container:/home/docker-jenkins-test/target/ ${currentWorkspace}/reports/