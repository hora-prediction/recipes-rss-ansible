#!/bin/bash

exec &> >(tee -a kieker-resource-monitor-control.log)
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
	if [ -f kieker-resource-monitor-control.pid ]; then
		echowithdate "Application is already running"
		echowithdate "If it is not running, delete kieker-resource-monitor-control.pid manually"
		#exit 1
	fi
	./bin/resourceMonitor.sh &
	PID=$!
	echo $PID > kieker-resource-monitor-control.pid
	echowithdate "pid = $PID"
	echowithdate "Done"
elif [ $1 = "stop" ]; then
	echowithdate "Stoping..."
	if [ ! -f kieker-resource-monitor-control.pid ]; then
		echowithdate "Cannot find kieker-resource-monitor-control.pid"
		echowithdate "Has the application been started?"
		#exit 1
	fi
	kill $(cat kieker-resource-monitor-control.pid)
	rm kieker-resource-monitor-control.pid
	echowithdate "Done"
else
	echousage
	exit 1
fi
