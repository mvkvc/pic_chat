#!/bin/bash

set +a
source .env
set -a

usage() {
    echo "Usage: $0 [create|start|stop|restart|destroy|status]"
    exit 1
}

if [ $# -eq 0 ] || [ $# -gt 1 ]; then
    usage
fi

case "$1" in
create)
    docker run -d \
        --name "$DB_NAME" \
        -p "$PG_PORT":5432 \
        -e POSTGRES_USER="$PG_USER" \
        -e POSTGRES_PASSWORD="$PG_PASS" \
        postgres:alpine
    ;;
start)
    docker start $DB_NAME
    ;;
stop)
    docker stop $DB_NAME
    ;;
restart)
    docker restart $DB_NAME
    ;;
destroy)
    docker rm $DB_NAME
    ;;
status)
    docker ps -a | grep $DB_NAME
    ;;
*)
    usage
    ;;
esac
