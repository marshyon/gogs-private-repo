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


