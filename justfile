default:
    @just --list

base_image := env('BASE_IMAGE', "centos")
docker_file := if base_image == "centos" { "DockerfileCentos" } else { "DockerfileUbuntu" }

build:
    docker build -t greenplum -f {{docker_file}} . 

start: build
    docker-compose up -d
start-one target:
    docker-compose up -d {{target}}
stop:
    docker-compose down
restart: stop start

shell target:
    -docker compose exec -it {{target}} bash

load +ARGS:
    docker compose exec bench pgbench {{ARGS}}

clean-ssh:
    -sudo rm -r ./ssh/data1
    -sudo rm -r ./ssh/data2 
    -sudo rm -r ./ssh/data3
    -sudo rm -r ./ssh/master 
    -sudo rm -r ./ssh/standby 
    -mkdir ./ssh/data1
    -mkdir ./ssh/data2
    -mkdir ./ssh/data3
    -mkdir ./ssh/master
    -mkdir ./ssh/standby

clean-data:
    -sudo rm -r ./data/data1/*
    -sudo rm -r ./data/data2/*
    -sudo rm -r ./data/data3/*
    -sudo rm -r ./data/mirror1/*
    -sudo rm -r ./data/mirror2/*
    -sudo rm -r ./data/mirror3/*
    -sudo rm -r ./data/master/*
    -sudo rm -r ./data/standby/*


kill-coordinator:
    docker compose kill coordinator

kill target:
    docker compose kill {{target}}

