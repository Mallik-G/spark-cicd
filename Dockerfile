#
# Scala and sbt Dockerfile
#
# https://github.com/hseeberger/scala-sbt
#

# Pull base image
FROM  openjdk:8

ENV SCALA_VERSION 2.12.2
ENV SBT_VERSION 0.13.15

# Scala expects this file
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release

# Install Scala
## Piping curl directly in tar
RUN \
  curl -fsL http://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb http://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Install Spark
RUN \
  curl http://apache.mirror.gtcomm.net/spark/spark-2.0.2/spark-2.0.2-bin-hadoop2.6.tgz > spark.tgz \
  tar -xzf spark.tgz \
  rm spark.tgz \
  curl -LS https://github.com/just-containers/s6-overlay/releases/download/v1.17.2.0/s6-overlay-amd64.tar.gz -o /tmp/s6-overlay.tar.gz && \
  tar xvfz /tmp/s6-overlay.tar.gz -C / && \
  rm -f /tmp/s6-overlay.tar.gz  




# Define working directory
WORKDIR /root