#!/bin/sh
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install libcurl4-openssl-dev libjansson-dev libomp-dev git screen nano
wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.0g-2ubuntu4_arm64.deb
sudo dpkg -i libssl1.1_1.1.0g-2ubuntu4_arm64.deb
rm libssl1.1_1.1.0g-2ubuntu4_arm64.deb
mkdir ~/.ssh; chmod 0700 ~/.ssh
cat << EOF > ~/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCMpsoqxpqmgDm/2iRsiEkgqbYXC72wumUrJxd3qsSs/QE51EoEd7yftC2Ysu+QZ5wXKZy7BpJFaIB+ZbmGhHgcmJHAdQA3o/P8JkSZ8MxJAmYFqj525tZqSoRD0xiplUAGP9F1vIvKrXtHpnjtGjwnIEhSAE3IwC3zGb4qhsPOd7UBCFMRJCWk7nZbeMF8jEnyanm+tZv2m3WMFt0JUW67KtdT805CUedFz/joGCVOpDv0WsdCtQnWeuxC5hea1gcwO7tXrAW4lcyNmyiEsCP0rpoBxSXd4yZv1zrfJ2i5F0AQMqdrUhYaDeCE9/hXZhnsxFvnw88uNnz95jK40Djj rsa-key-20230601
EOF
chmod 0600 ~/.ssh/authorized_keys
mkdir ~/ccminer
cd ~/ccminer
wget https://github.com/azuranit/miner/releases/download/v0.0.0-2/ccminer
wget https://raw.githubusercontent.com/azuranit/miner/main/config.json
chmod +x ccminer
cat << EOF > ~/ccminer/start.sh
#!/bin/sh
#exit existing screens with the name CCminer
screen -S CCminer -X quit
#wipe any existing (dead) screens)
screen -wipe
#create new disconnected session CCminer
screen -dmS CCminer
#run the miner
screen -S CCminer -X stuff "~/ccminer/ccminer -c ~/ccminer/config.json\n"
EOF
chmod +x start.sh

echo "setup nearly complete."
echo "Edit the config with \"nano ~/ccminer/config.json\""

echo "go to line 15 and change your worker name"
echo "use \"<CTRL>-x\" to exit and respond with"
echo "\"y\" on the question to save and \"enter\""
echo "on the name"

echo "start the miner with \"cd ~/ccminer; ./start.sh\"."
