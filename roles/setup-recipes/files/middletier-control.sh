#!/bin/bash

exec &> >(tee -a logs/middletier-control.log)
exec 2>&1

echowithdate() {
	echo "$(date -u) $0 $1"
}

echousage() {
	echowithdate "Usage: $0 ( start | stop )"
}

if [ "$#" -ne 1 ]; then
	echousage
	exit 1
fi

if [ $1 = "start" ]; then
	echowithdate "Starting..."
	if [ -f middletier-control.pid ]; then
		echowithdate "Application is already running"
		echowithdate "If it is not running, delete middletier-control.pid manually"
		#exit 1
	fi
	java -jar rss-middletier/build/libs/rss-middletier-*SNAPSHOT.jar &
	PID=$!
	echo $PID > middletier-control.pid
	echowithdate "pid = $PID"
	echowithdate "Done"
elif [ $1 = "stop" ]; then
	echowithdate "Stoping..."
	if [ ! -f middletier-control.pid ]; then
		echowithdate "Cannot find middletier-control.pid"
		echowithdate "Has the application been started?"
		#exit 1
	fi
	kill $(cat middletier-control.pid)
	rm middletier-control.pid
	echowithdate "Done"
else
	echousage
	exit 1
fi
