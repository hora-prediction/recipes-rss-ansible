#!/bin/bash

exec &> >(tee -a logs/edge-control.log)
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
	if [ -f edge-control.pid ]; then
		echowithdate "Application is already running"
		echowithdate "If it is not running, delete edge-control.pid manually"
		#exit 1
	fi
	java -javaagent:kieker-{{ kieker_version }}-aspectj.jar -Dkieker.monitoring.configuration=kieker.monitoring.properties -Dkieker.monitoring.skipDefaultAOPConfiguration=true -cp rss-edge/build/libs/rss-edge-0.1.0-SNAPSHOT.jar com.netflix.recipes.rss.server.EdgeServer &
	PID=$!
	echo $PID > edge-control.pid
	echowithdate "pid = $PID"
	echowithdate "Done"
elif [ $1 = "stop" ]; then
	echowithdate "Stoping..."
	if [ ! -f edge-control.pid ]; then
		echowithdate "Cannot find edge-control.pid"
		echowithdate "Has the application been started?"
		#exit 1
	fi
	kill $(cat edge-control.pid)
	rm edge-control.pid
	echowithdate "Done"
else
	echousage
	exit 1
fi
