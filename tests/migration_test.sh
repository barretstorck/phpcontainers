#!/bin/bash
# tests/migration_test.sh

# Temporary verify script
./bin/builddockerfile 8.2-fpm bz2 yaml > test_output.dockerfile

if grep -q "RUN apt-get update" test_output.dockerfile; then
    echo "PASS: Consolidated apt-get update found"
else
    echo "FAIL: Consolidated apt-get update NOT found"
    exit 1
fi

if grep -q "libbz2-dev" test_output.dockerfile && grep -q "libyaml-dev" test_output.dockerfile; then
    echo "PASS: Dependencies found"
else
    echo "FAIL: Dependencies missing"
    exit 1
fi
