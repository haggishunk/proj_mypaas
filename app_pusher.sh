#!/usr/bin/bash

echo "*** APP_PUSHER ***"
HOST_DOKKU=$1
APP_NAME=$2
APP_PATH=$3
APP_BASE=$(echo $APP_PATH | sed "s/.*\///")

if [ -d $APP_BASE ]
then
    echo "You already have a local copy of the application: $3"
    # cd ruby-rails-sample;
    # git remote remove dokku;
    # cd ..;
    cd $APP_BASE
    git remote rm dokku
else 
    echo "Downloading application: $APP_BASE"
    git clone "git@github.com:$APP_PATH"
    cd $APP_BASE
fi
echo "Adding dokku git remote: dokku@$HOST_DOKKU:$APP_NAME"
git remote add dokku dokku@$HOST_DOKKU:$APP_NAME


GIT_SSH_COMMAND="ssh -o StrictHostKeyChecking=no" git push dokku master;
