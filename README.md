# Docker DataVault

Files for setting up local Docker containers in order to run DataVault

## Clone repository

This repository contains a submodule in order to clone everything run the following command:

`git clone --recursive git@github.com:DataVault/docker-datavault.git`

Then run the setup script:

`./setup_docker.sh`

This will create several empty directoreis shared with the docker containers.

Then you might want to ad some files into the `/tmp/Users/`, this will be used as the local storage by the containers.

## Docker Compose

We are using [Docker Compose](https://docs.docker.com/compose/) to start the different services:
* MySQL DB - using `mysql:5.7` image
* RabbitMQ - using `bitnami/rabbitmq:latest` image
* The Webapp + Brokers - using local DockerFile based on `tomcat:7-jre8`.
* Workers - using local DockerFile based on `java:8`.

The containers require the application to be build fires:

`mvn clean package`

Then, you can build all services with the following command:

`docker-compose build`

And start each service with:

`docker-compose up`

Once started, you should be able to access the application at: http://localhost:8080/datavault-webapp

You can then access the application container using:

`docker-compose exec web /bin/bash`

## Supervisor

We are using [Supervisor](https://docs.docker.com/engine/admin/multi-service_container/) to start the Tomcat and the workers on the web container.

The configuration is in `supervisor_datavault.conf`