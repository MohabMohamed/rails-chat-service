#!/bin/sh

if [ -f /app/tmp/pids/server.pid ]; then
  rm /app/tmp/pids/server.pid
fi
whenever --update-crontab
rake db:migrate
bin/rails server -b 0.0.0.0 -p $PORT