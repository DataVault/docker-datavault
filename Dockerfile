# Use an official java 7 as a parent image
# FROM ubuntu:latest
FROM tomcat:7-jre8

MAINTAINER William Petit <w.petit@ed.ac.uk>

ARG LOCAL_DATAVAULT_DIR="./datavault"

ENV MAVEN_OPTS "-Xmx1024m"
ENV DATAVAULT_HOME "/docker_datavault-home"

# Update ubuntu
RUN apt-get update && apt-get install -y procps

# Install usefull tools
RUN apt-get -y install vim

# Install MySql client
RUN apt-get install -y mysql-client

# Install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

ADD supervisor_datavault.conf /etc/supervisor/conf.d/datavault.conf

# Couldn't use the whole directory as volume or datavault.properties gets overwritten
ADD datavault/datavault-assembly/target/datavault-assembly-1.0-SNAPSHOT-assembly/datavault-home /docker_datavault-home
# Use customised properties
ADD datavault.properties /docker_datavault-home/config/datavault.properties

# Some dummy data (if using 'local storage')
RUN mkdir -p /Users
RUN mkdir /Users/dir
RUN echo "file 1" > /Users/dir/file
RUN ln -s /Users/dir/file /Users/dir/symfile
RUN ln -s /Users/dir /Users/symdir

# RUN sed -i 's/appBase=\"webapps\"/appBase=\"\/vagrant_datavault-home\/webapps\"/' /usr/local/tomcat/conf/server.xml
RUN ln -s $DATAVAULT_HOME/webapps/datavault-broker /usr/local/tomcat/webapps/datavault-broker
RUN ln -s $DATAVAULT_HOME/webapps/datavault-webapp /usr/local/tomcat/webapps/datavault-webapp

WORKDIR /docker_datavault-home/lib

# Make port 80 available to the world outside this container
EXPOSE 8080

CMD supervisord -c /etc/supervisor/supervisord.conf -n