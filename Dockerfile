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

#versions
ENV SCALA_TAR_URL http://www.scala-lang.org/files/archive
ENV SCALA_VERSION 2.10.4
ENV SBT_VERSION 0.13.6


#install scala
RUN wget $SCALA_TAR_URL/scala-$SCALA_VERSION.tgz
RUN tar xvf scala-$SCALA_VERSION.tgz
RUN mv scala-$SCALA_VERSION /usr/lib
RUN rm scala-$SCALA_VERSION.tgz
RUN ln -s /usr/lib/scala-$SCALA_VERSION /usr/lib/scala

ENV PATH $PATH:/usr/lib/scala/bin

# install sbt
RUN wget -O /usr/local/bin/sbt-launch.jar http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar
ADD scripts/sbt.sh /usr/local/bin/sbt
RUN chmod 755 /usr/local/bin/sbt
