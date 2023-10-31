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