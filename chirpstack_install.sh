#!/bin/bash

echo "Welcome to installing and configuring ChirpStack on Debian\Ubuntu"
echo "---------"

echo "Renewing repositories"
sudo apt update
sudo apt upgrade
echo "---------"

echo "Begining to install mosquitto..."
sudo apt install mosquitto
echo "---------"

echo "Begining to install mosquitto-clients"
sudo apt install mosquitto-clients
echo "---------"

echo "Begining to install redis-server"
sudo apt install redis-server
echo "---------"

echo "Begining to install redis tools"
sudo apt install redis-tools
echo "---------"

echo "Begining to install postgresql"
sudo apt install postgresql
echo "---------"

echo ""
echo "All components has been installed"
echo ""
echo "---------"

echo "You are in the postgres mode now."
echo "You have to type the following commands:"
echo "create role chirpstak with login password 'chirpstack'"
echo "create database chirpstack with owner chirpstack"
echo "\c chirpstack"
echo "create extension pg_trgm"
echo "\q"
sudo -u postgres psql
echo "---------"

echo "Setting up ChirpStack repository"
sudo apt install apt-transport-https dirmngr
echo "---------"

echo "Setting up the key for ChirpStak repository"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1CE2AFD36DBCCA00
echo "---------"

echo "Adding the repository to list"
sudo echo "deb https://artifacts.chirpstack.io/packages/4.x/deb stable main" | sudo tee /etc/apt/sources.list.d/chirpstack.list
echo "---------"

echo "Updating the package cache:"
sudo apt update
echo "---------"

echo "Installing ChirpStack"
sudo apt install chirpstack
echo "---------"

echo "Configuring ChirpStack"
sudo systemctl start chirpstack
echo "ChirpStack has been started"
sudo systemctl enable chirpstack
echo "ChirpStack has been enabled"
echo "---------"

echo "Check the log-out"
sudo journalctl -f -n 100 -u chirpstack
echo "---------"

echo "All done"
