#!/bin/bash
#
# Ceilometer Alarm Notifier monitoring script
#
# Author: Swann Croiset
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

#set -e

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4


PID=$(pidof -x ceilometer-alarm-notifier)
if [ -z $PID ]; then
	PID=$(ps auxf|grep ceilometer-alarm-notifier|grep python | awk '{print $2}')
fi
# ceilometer-alarm-notifier

AMQP_PORT=$(grep amqp /etc/services|head -n 1|cut -f 1 -d '/'| awk '{print $2}')
if ! KEY=$(netstat -nepta 2>/dev/null | grep $PID 2>/dev/null | grep ":$AMQP_PORT") || test -z "$PID"
then
    echo "Ceilometer Alarm evaluator is not connected to AMQP."
    exit $STATE_CRITICAL
fi

echo "Ceilometer Alarm evaluator is working."


