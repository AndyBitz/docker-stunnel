# docker/stunnel

This image creates a container that runs stunnel. It can be used within a service to only allow secure connection to the outside.


## Usage

Here's an example of a `docker-compose.yml` file that runs redis and stunnel.

```yaml
version: "3"
services:
  redis:
    image: redis:alpine
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - '/data/redis.conf'
    volumes:
      - ./redis:/data
    networks:
      - my-network

  stunnel:
    image: andybitz/stunnel:latest
    deploy:
      restart_policy:
        condition: on-failure
    command:
      - /data/stunnel.conf
    volumes:
      - ./stunnel:/data
    ports:
      - "6380:6380"
    networks:
      - my-network

networks:
  my-network:
```

The projects folder structure looks something like this:

```
/my-service
  /redis
    redis.conf
  /stunnel
    stunnel.conf
    certificate.pem
```

Both folders, `redis` and `stunnel`, in `my-service` are used as volumes. That allows us to pass on some config files and a certificate to stunnel an redis. 

> The command section allows us to specify some arguments for `stunnel` and `redis-server`.
> When the conainer starts the commands that are executed will look like
> `redis-server /data/redis.conf` and `stunnel /data/stunnel.conf`

The `stunnel.conf` looks like this:

```
cert = /data/certificate.pem
foreground = yes

[redis]
accept = :::6380
connect = redis:6379
```

> `foreground = yes` is required, otherwise the container will just exit


## Build & Publish

* `git clone https://github.com/andybitz/docker-stunnel`
* `cd docker-stunnel`
* `docker build -t stunnel .`
* `docker tag stunnel andybitz/stunnel:1.0.0`
* `docker tag stunnel andybitz/stunnel:latest`
* `docker push andybitz/stunnel:1.0.0`
* `docker push andybitz/stunnel:lastest`

> *note to self*


### Questions, suggestions or anything else?

Go the the github repo [andybitz/docker-stunnel](https://github.com/AndyBitz/docker-stunnel).

