#!/usr/bin/bash

git clone git@github.com:heroku/ruby-rails-sample.git
cd ruby-rails-sample
git remote add dokku dokku@mypaas.pantageo.us:helloclock
git push dokku master
