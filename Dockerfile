FROM centos:centos7

MAINTAINER Roberto Barbosa <rb@scigility.com>

RUN  yum install -y epel-release
RUN  yum update -y && yum install -y \
  git \
  unzip \
  tar \
  wget \
  httpie

RUN \
  curl -s -O https://s3.eu-central-1.amazonaws.com/com.scigility.archives/java/jdk-8u121-linux-x64.rpm && \
  yum localinstall -y ./jdk-8u121-linux-x64.rpm && \
  alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_121/jre/bin/java 20000 && \
  alternatives --install /usr/bin/javac javac /usr/java/jdk1.8.0_121/bin/javac 20000 && \
  alternatives --set java /usr/java/jdk1.8.0_121/jre/bin/java && \
  alternatives --set javac /usr/java/jdk1.8.0_121/bin/javac && \
  ls -lA /etc/alternatives/ | grep java && \
  java -version && \
  javac -version && \
  echo '' >> /etc/profile && \
  echo '# set JAVAHOME' >> /etc/profile && \
  echo 'export JAVA_HOME=/usr/java/jdk1.8.0_121' >> /etc/profile && \
  echo 'export PATH=$JAVA_HOME/bin:$PATH' >> /etc/profile && \
  source /etc/profile

# install sbt
ENV SBT_VERSION 0.13.6
#
RUN curl  -sLo /tmp/sbt.tar.gz 'https://dl.bintray.com/sbt/native-packages/sbt/${SBT_VERSION}/sbt-${SBT_VERSION}.tgz'
RUN tar xzf /tmp/sbt.tar.gz -C /opt && rm /tmp/sbt.tar.gz && \
RUN ln -s /opt/sbt/bin/sbt /usr/bin/

# install scala
ENV SCALA_TAR_URL http://www.scala-lang.org/files/archive
ENV SCALA_VERSION 2.10.4
#
RUN wget $SCALA_TAR_URL/scala-$SCALA_VERSION.tgz
RUN tar xvf scala-$SCALA_VERSION.tgz
RUN mv scala-$SCALA_VERSION /usr/lib
RUN rm scala-$SCALA_VERSION.tgz
RUN ln -s /usr/lib/scala-$SCALA_VERSION /usr/lib/scala
