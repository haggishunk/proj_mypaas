# install prerequisites
apt-get update -qq > /dev/null
apt-get install -qq -y apt-transport-https

# install docker
wget -nv -O - https://get.docker.com/ | sh

# install dokku
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | tee /etc/apt/sources.list.d/dokku.list
apt-get update -qq > /dev/null

echo "dokku dokku/web_config boolean false" | debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | debconf-set-selections
echo "dokku dokku/hostname string paas.pantageo.us" | debconf-set-selections
echo "dokku dokku/key_file string /root/.ssh/id_rsa.pub" | debconf-set-selections

apt-get install -qq -y --allow-unauthenticated dokku
dokku plugin:install-dependencies --core
