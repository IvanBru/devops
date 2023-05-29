#!/bin/bash

response=$(curl -s -o /dev/null -w "%{http_code}" http://apache-host:8080)

if [[ $response != 2* && $response != 3* ]]; then
  echo "$(date): Apache-host response code: $response" >> /httpd/logs/host.logs