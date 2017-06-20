FROM openjdk:8

MAINTAINER Roberto Barbosa <rb@scigility.com>

wget http://apt.typesafe.com/repo-deb-build-0002.deb
sudo dpkg -i repo-deb-build-0002.deb
sudo apt-get update
sudo apt-get install sbt
sbt sbtVersion

# Define working directory
WORKDIR /root
