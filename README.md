# Docker DataVault

Files for setting up local Docker containers in order to run DataVault

## Clone repository

This repository contains a submodule in order to clone everything run the following command:

`git clone --recursive git@github.com:DataVault/docker-datavault.git`

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

If you want several workers running use --scale:
`docker-compose up --scale workers=3`

Once started, you should be able to access the application at: http://localhost:8080/datavault-webapp

You can then access the application container using:

`docker-compose exec web /bin/bash`

Start a list of services:

`docker-compose up rabbitmq workers`

Youcan also use the option -d to run them in detached mode and then view the logs with the log option:

`docker-compose up -d`
`docker-compose logs -f`

## Supervisor (not default)

[Supervisor](https://docs.docker.com/engine/admin/multi-service_container/) can be use to start the Tomcat and the workers on the web container.

The configuration is in `supervisor_datavault.conf`

## RabbitMq command tool

You can download `rabbitmqadmin` at http://localhost:15672/cli and use it to trigger deposit or retrieve:

`rabbitmqadmin --password=datavault -u datavault publish exchange=amq.default routing_key=datavault < ./rabbitmq_deposit_sent.json`