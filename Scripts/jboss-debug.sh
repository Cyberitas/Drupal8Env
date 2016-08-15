#!/bin/sh
RUNAS="vagrant"
CONTROLLERADDRESS="0.0.0.0:9999"

if [ "`/usr/bin/whoami`" != "${RUNAS}" ] ; then
   echo "Must be the ${RUNAS} user to start/stop JBoss7, exiting"
   exit
fi

# nope: export JAVA_HOME="/usr/java/default/"

case "${1}" in
        start)
		if [[ 1 -eq $(ps -ef -U ${RUNAS} | grep 'java '| grep -v grep | grep -v tail | grep -c /srv/jboss) ]]; then
                        echo "jboss appears to be running, do not start again, exiting."
                        exit
                else
                        echo "starting JBOSS app server: /srv/jboss/bin/ ; nohup ./standalone.sh --debug 33738 &"
                fi
                if [ ! -d /srv/jboss/bin/ ] ; then 
                        echo "missing directory: /srv/jboss/bin/"
                        echo "exiting."
                        exit
                fi
                rm -f /srv/jboss/bin/nohup.out >/dev/null 2>&1
		rm -f /srv/jboss/bin/standalone.sh.stdout.log >/dev/null 2>&1
		rm -f /srv/jboss/bin/standalone.sh.stderr.log >/dev/null 2>&1
                # . ~/.bash_profile ; cd /srv/jboss/bin && nohup ./standalone.sh > standalone.sh.stdout.log 2> standalone.sh.stderr.log < /dev/null &
                . ~/.bash_profile ; cd /srv/jboss/bin && nohup ./standalone.sh --debug 33738 > /dev/null 2> /dev/null < /dev/null &
                sleep 2
                ;;
	stop)
		/srv/jboss/bin/jboss-cli.sh --connect command=:shutdown --controller=${CONTROLLERADDRESS}
		;;
	*)
		echo "jboss7.sh [start|stop]"
		;;

esac
