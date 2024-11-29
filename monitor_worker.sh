#!/bin/bash


if [ ! $# -eq 1 ]
then
        echo "One argument (program name) is expected. Given: $#"
        exit 1
fi

program_name=$1
pid=$(pidof -x -s $program_name)
pidof_status=$?
previous_pid < /var/monitor/previous_pid  # TODO create that file and check that it exists

case $pidof_status in
        1) ;;  # Script is switched off or not found"
        0) if [[ (! -z $pid) && ($pid -eq $previous_pid || (! -z $previous_pid)) ]]; then
                # Script is running
                curl --fail-with-body \
                        --header "Content-Type: application/json" \
                        --request POST \
                        --data "{\"message\": \"Script is running\", \"timestamp\": \"$(date)\"}" \
                        --max-time 4 \
                        https://test.com/monitoring/test/api
                curl_status=$?
                if [ ! $curl_status -eq 0 ]; then  # API is not available
                        echo "$(date): Script is running" >> /var/log/monitoring.log
                fi
           elif [[ ! -z $pid ]] ; then
           # Script was restarted
           echo "$(date): Script was restarted" >> /var/log/monitoring.log
           fi;;
esac

$pid > /var/monitor/previous_pid  # TODO create that file and check that it exists

