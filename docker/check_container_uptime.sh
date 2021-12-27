#!/usr/bin/env bash

## Intro:
### It's hard to know container uptime:
### * `docker stats` doesn't show It
### * `docker exec -i $CONTAINER_NAME uptime` will show the uptime of the host itself
### 
### So, you can either use `docker inspect` or check `Access` time of `/proc/1` inside container
### The script simplifies `/proc/1` approach

## Usage
### $0 without arguments will print uptime of all running containers
### `$0 <container_name>` will print uptime of all running containers

## check_container_uptime.sh
get_container_names(){
    docker ps --format '{{.Names}}'
}

get_container_uptime(){
    docker exec -i ${1} stat /proc/1 | awk -F' |-|:' '/Access: [0-9]{4}/ {timestring = sprintf("%s %s %s %s %s %s", $3, $4, $5, $6, $7, $8); time=mktime(timestring); printf "Uptime is %s seconds\n", (systime() - time)} '
}

if [[ -z $1 ]]; then
    for CONTAINER_NAME in $( get_container_names ); do
        printf "$CONTAINER_NAME:\t"
        get_container_uptime $CONTAINER_NAME
    done
else
    get_container_uptime $1
fi