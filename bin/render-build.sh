#!/usr/bin/env bash
echo "Running build script on render"
# exit on error
set -o errexit

echo "Running bundle install"
bundle install
echo "Running assets precompile"
bundle exec rails assets:precompile
bundle exec rails assets:clean
echo "Running db migration"
bundle exec rails db:migrate
echo "Running db seed"
bundle exec rails db:seed
