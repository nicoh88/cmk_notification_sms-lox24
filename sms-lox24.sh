#!/bin/bash
# SMS via LOX24 SMS Gateway

###========================================###
# Nico Hartung <nicohartung1@googlemail.com> #
###========================================###

###===========###
##  Variables  ##
###===========###

DATE=`date +%Y-%m-%d`
NOW=`date +%Y-%m-%d_%H-%M`

NAME="sms-lox24"
LOGFILE=/tmp/${NAME}_${DATE}.log

CURL="/usr/bin/curl -s -g"
HOSTSUBJECT="$NOTIFY_NOTIFICATIONTYPE $NOTIFY_HOSTALIAS"
SERVICESUBJECT="$NOTIFY_NOTIFICATIONTYPE $NOTIFY_HOSTALIAS $NOTIFY_SERVICEDESC"

# Debug
DEBUG=0                                 # 0=disable / 1=enable
#NOTIFY_CONTACTPAGER="0049123456789"    # for testing
#HOSTSUBJECT="Testing"                  # for testing

# LOX24
LOX24USER="USERID?"
LOX24PW="MD5-HASH?"
LOX24TARIF="TARIF?"
LOX24FROM="FROM?"
LOX24URL_START="https://www.lox24.eu/API/httpsms.php?konto=$LOX24USER&password=$LOX24PW&service=$LOX24TARIF"
LOX24URL_END="from=$LOX24FROM&to=$NOTIFY_CONTACTPAGER"

###========###
##  Script  ##
###========###

### contactpager
if [[ -z $NOTIFY_CONTACTPAGER ]]; then
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - FAIL (no pagernumber)"  >> $LOGFILE
        exit 1
    else
        exit 1
    fi
fi

### service notification
if [ "$NOTIFY_WHAT" = "SERVICE" ]; then
    # without comment
    if [[ -z $NOTIFY_NOTIFICATIONCOMMENT ]]; then
        MESSAGE=`echo "$SERVICESUBJECT - $NOTIFY_SERVICEOUTPUT" | sed 's/ /%20/g'`
    # with comment
    else
        MESSAGE=`echo "$SERVICESUBJECT - <$NOTIFY_NOTIFICATIONCOMMENT> (by $NOTIFY_NOTIFICATIONAUTHOR) $NOTIFY_SERVICEOUTPUT" | sed 's/ /%20/g'`
    fi
### host notification
else
    # without comment
    if [[ -z $NOTIFY_NOTIFICATIONCOMMENT ]]; then
        MESSAGE=`echo "$HOSTSUBJECT - $NOTIFY_HOSTOUTPUT" | sed 's/ /%20/g'`
    # with comment
     else
        MESSAGE=`echo "$HOSTSUBJECT - <$NOTIFY_NOTIFICATIONCOMMENT> (by $NOTIFY_NOTIFICATIONAUTHOR) $NOTIFY_HOSTOUTPUT " | sed 's/ /%20/g'`
    fi
fi

### send message
if [ "$MESSAGE" != "%20%20-%20" ]; then
    COMMAND="$CURL $LOX24URL_START&text=$MESSAGE&$LOX24URL_END"
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - $COMMAND"          >> $LOGFILE
        env | grep NOTIFY_ | sort       >> $LOGFILE
        $COMMAND                        >> $LOGFILE
    else
        $COMMAND                        >> /dev/null
    fi
else
    if [ "$DEBUG" = "1" ]; then
        echo "$NOW - FAIL (empty message)"  >> $LOGFILE
        exit 1
    else
        exit 1
    fi
fi
