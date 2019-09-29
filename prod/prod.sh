#!/usr/bin/env bash

# Updating packages
apt-get update

echo "\n----- Installing Apache, Java 8, pip and Unzip ------\n"
apt-get install -y apache2 openjdk-8-jdk
update-alternatives --config java

echo "\n----- MyCollab setup ------\n"

# ---------------------------------------
#          MyCollab Setup
# ---------------------------------------

git clone https://github.com/JiKook31/DevOpsProject.git
# ./startup.sh