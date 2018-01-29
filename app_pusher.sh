#!/usr/bin/bash

echo "*** APP_PUSHER ***"

if [ -d $3 ];
then
    echo "You already have a local copy of the application: $3";
    # cd ruby-rails-sample;
    # git remote remove dokku;
    # cd ..;
    cd $3;
else 
    echo "Downloading application: $3";
    git clone "git@github.com:$3.git";
    cd $3;
    echo "Adding dokku git remote: dokku@$1:$2";
    git remote add dokku dokku@$1:$2;
fi;


GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git push dokku master;
