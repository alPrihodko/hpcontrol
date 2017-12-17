#!/bin/bash

err() {
    echo "Error on line $1"
}

trap 'err $LINENO' ERR

HOST=192.168.1.20
HOST=sasha123.ddns.ukrtel.net
SERVICE=hpcontrol
PORT=75

deploy=pi\@"$HOST":/usr/local/$SERVICE
deploy_home=pi\@"$HOST":/home/pi/$SERVICE
deploy_ui=pi\@"$HOST":/home/pi/"$SERVICE"/ui


ssh -p75 pi\@$HOST "mkdir -p /home/pi/$SERVICE" || exit 1
ssh -p75 pi\@$HOST "mkdir -p /home/pi/$SERVICE/ui" || exit 1

#scp -P75 -r vc/build/default $deploy_ui 

if [ "$1" == "all" ]; then
    ssh -p$PORT pi\@$HOST "sudo service $SERVICE stop" || exit 1
    ssh -p$PORT pi\@$HOST "cd $deploy && git pull" || exit 1
    #scp -P$PORT $SERVICE $deploy || exit 1
    ssh -p$PORT pi\@$HOST "sudo service $SERVICE start" || exit 1
fi

echo "Success"
