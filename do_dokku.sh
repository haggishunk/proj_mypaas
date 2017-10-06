# install prerequisites
sudo apt-get update -qq > /dev/null
sudo apt-get install -qq -y apt-transport-https

# install docker
wget -nv -O - https://get.docker.com/ | sh

# install dokku
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
sudo apt-get update -qq > /dev/null
sudo apt-get install -qq -y --allow-unauthenticated dokku
sudo dokku plugin:install-dependencies --core

echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/hostname string mypaas.me" | sudo debconf-set-selections
echo "dokku dokku/key_file string /root/.ssh/mypaas.pub" | sudo debconf-set-selections
