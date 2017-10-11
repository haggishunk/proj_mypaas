#!/usr/bin/bash

git clone git@github.com:heroku/ruby-rails-sample.git
cd ruby-rails-sample
git remote add dokku dokku@mypaas.pantageo.us:mypaas.pantageo.us
git push dokku master
