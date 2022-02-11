#!/bin/bash

# Package for the say implementation -> https://manpages.ubuntu.com/manpages/focal/man1/say.1.html

REQUIREMENTS="gnustep-gui-runtime"
TIME=60
VERIFY=000

if [ $1 ]
    then
        dpkg -s ${REQUIREMENTS} &> /dev/null
        
        if [ $? -ne 0 ]
            then
                echo "In order to listen the verification, you need to install the following package -> ${REQUIREMENTS}"
        fi
        HTTP_CODE=000
        while [ $HTTP_CODE -eq $VERIFY ]
            do
                HTTP_CODE=$(curl --max-time 1 --write-out "%{http_code}\n" "$1" --silent)
            if [ "$HTTP_CODE" -eq $VERIFY &>/dev/null ]
            then
                echo "No luck -> $HTTP_CODE"
                sleep $TIME
            else
                break
            fi
        done
        echo "Yes!"
        echo "vvv Here is the output vvv"
        echo $HTTP_CODE
        say "The site $1 is online"
else
    echo "Please specify an url or ip"
fi
