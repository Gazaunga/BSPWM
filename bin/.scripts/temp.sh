#!/bin/bash
__=`sensors | grep Core` && echo \(`echo $__ | sed 's/.*+\(.*\).C\(\s\)\+(.*/\1/g' | tr "\n" "+" | head -c-1`\)\/`echo $__ | wc -l` | bc && unset __
# Uses the "sensors" command and bc along with sed, grep, head, and tr to fetch and calculate the average CPU temperature.
