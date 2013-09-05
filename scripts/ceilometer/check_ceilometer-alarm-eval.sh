#!/bin/bash
#
# Ceilometer Alarm evaluator monitoring script
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


PID=$( ps -ef | grep ceilometer-alarm-singleton | grep python | awk {'print$2'} | tail -n 1)

if [ -z $PID ];
then
    echo "Ceilometer Alarm evaluator is not connected to AMQP."
    exit $STATE_CRITICAL
fi

echo "Ceilometer Alarm evaluator is working."

