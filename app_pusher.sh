#!/usr/bin/bash

echo "*** APP_PUSHER ***"

if [ -d ruby-rails-sample ];
then 
    cd ruby-rails-sample;
    git remote remove dokku;
    cd ..;
else 
    git clone git@github.com:heroku/ruby-rails-sample.git;
fi;

cd ruby-rails-sample;
git remote add dokku dokku@$1:$2;
git push dokku master;
