sudo apt install -y openvswitch-switch

mkdir mininet
curl -L https://github.com/mininet/mininet/archive/master.tar.gz | tar xz -C mininet --strip=1

mininet/util/install.sh -n
