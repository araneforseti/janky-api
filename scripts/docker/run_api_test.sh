#!/bin/bash
set -e
docker-compose -p janky_api_test up --build -d
docker-compose -p janky_api_test run --rm janky_api bundle exec rake api || true
docker-compose -p janky_api_test down
