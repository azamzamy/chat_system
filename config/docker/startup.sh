#! /bin/sh

rm -f /var/app/tmp/pids/server.pid;

sh ./config/docker/prepare-db.sh

# Start the app
bundle exec puma -C config/puma.rb
