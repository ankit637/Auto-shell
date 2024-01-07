#!/bin/bash

echo "showing Login logs into logs..."

cd /var/log

cat boot.log | grep -i login
