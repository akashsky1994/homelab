
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo apt-get update
sudo apt-get install docker-compose-plugin
docker compose version

cd ~
git clone https://github.com/akashsky1994/vaultwarden-setup.git
cd vaultwarden-setup
cp /tmp/.env .

docker compose build
docker compose up -d