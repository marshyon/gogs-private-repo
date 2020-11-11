# Running your own git repository using Gogs and Docker

This project is meant to make it straight forward to run a self-hosted Gogs code repository
using Docker and mounted volumes to store its data so this can be backed up relatively
easily.

This is tested using a Raspberry Pi 400 with a 32Gb SD Card but could equally work on
any host running Docker.

It is not meant to be deployed into Swarm or Kubernetes in this single node mode of 
working - thus the Pi being its primary target for now.

## Prerequisites

A system with Docker and Docker-compose pre-installed.

## Initial setup

in the `repo` directory, copy the file .example.env to .env and be sure to edit .env file 
to have at least `EXTERNAL_URL` and `DOMAIN` values set appropriately for your environment
`SECRET_KEY` is best changed too.

then run 

```
./config.sh 
```

which will create a configuration file in `custom/conf/app.ini` that Gogs will use for its
configuration 

## Running up the containers

at the root of the project ( where `docker-compose.yaml` is located ) run :

```
docker-compose up -d
```

Gogs should now be running on port 3333 ( or the port you configured in `.env` ) on the host that docker is running on.

This packaging of Gogs uses sqlite3 as its back-end database.

An initial user will need to be registered and this will be an admin user.

Data will be stored into `repo/data`, `repo/custom/conf` and `repo/repositories/`

These directories may be backed up and restored to a system with docker and this repo installed of the same domain name or 
IP addresss as configured in `.env`

## Shutting down 

the running containers can be shut down with :

```
docker-compose stop
```

and be removed ( not however removing the 3 data directories ) with 

```
docker-compose down
```

# Webbooks

Gogs, like other Github like hosted repositories, can emit events via sending `POST` event to an api endpoint.

## gogs-private-repo_webhook node app

To see this working and to test out Gogs 'webhook' features, this compose config also bundles a
simple Node app that will start up on port 4000. It accepts json 'POST' data at the url '/data'. 

this can be tested with `curl` :

```
curl --location --request POST 'http://<ip address or hostname of docker host>:4000/data' \
--header 'Content-Type: application/json' \
--data-raw '{
    "json-parsing": "just with json",
    "no": "body-parser"
}'
```

The docker-compose script configures the node app to run a script called `do_something.sh` located in the scripts directory of webhookapp. This may be changed to run anything from within the running
container that the container permits but it will need changed to access a repository that is running on the Gogs service. The script should be self explanatory in this regard and uses an API key created in Gogs under `Your Settings` ( top right user icon ) => `Applications` => `Generate New Token`. The example script checks out and pulls the latest updates from one of the repositories hosted in the Gogs server instance.

## Enabling webhooks in Gogs

Inside of a repository in Gogs under `Settings` => `Webhooks` add a new webhook of type `Gogs`.

For Payload URL enter the url of the node app ( using the IP address / hostname of the Docker node that was configured in `.env` when configuring the app ), for example :

> http://gogs-server.localnet:4000/data

default of 'just the push event' should be sufficent but there is fine grained control over what events to trigger the web hook under 'Let me choose what I need'.

Use `Test Delivery` to check this is working and save the config. This will run a `POST` to the endpoint, backing up the repository ( in the case of the example script ) to a mounted directory on the host.
