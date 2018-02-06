#!/bin/bash
set -e
ruby janky_api.rb &
bundle exec rake api
