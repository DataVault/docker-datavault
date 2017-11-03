# Docker DataVault

Files for setting up local Docker containers in order to run DataVault

## Clone repository

This repository contains a submodule in order to clone everything run the following command:

`git clone git@github.com:DataVault/docker-datavault.git`

## Docker Compose

We are using [Docker Compose](https://docs.docker.com/compose/) to start the different services:
* MySQL DB - using `mysql:5.7` image
* RabbitMQ - using `bitnami/rabbitmq:latest` image
* The Webapp + Workers + Brokers - using local DockerFile.

Later we might want to sepparate the last in 3 different containers.

You can build each service with the following command:

`docker-compose build`

And start each service:

`docker-compose up`

Once started, you should be able to access the application at: http://localhost:8080/datavault-webapp

You can then access the application container using:

`docker-compose exec web /bin/bash`

## DockerFile

The DockerFile is based on `tomcat:7-jre8` image.

## Supervisor

We are using [Supervisor](https://docs.docker.com/engine/admin/multi-service_container/) to start the Tomcat and the workers on the web container.

The configuration is in `supervisor_datavault.conf`