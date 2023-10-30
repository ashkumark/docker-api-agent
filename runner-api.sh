#!/bin/sh

echo "Run automated API tests (using runner script)..."
#mvn -f pom.xml test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
mvn test -Dtest=TestRunner -Dcucumber.filter.tags=$TYPE
#mvn test -Dcucumber.filter.tags=$TYPE
echo "API tests run completed..."

