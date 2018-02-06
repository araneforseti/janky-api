#!/usr/bin/env bash

redis-server &
ruby janky-api.rb

