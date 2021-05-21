#!/bin/bash

key=$1

prepare(){
YUM_CMD=$(which yum)
APT_GET_CMD=$(which apt-get)

 if [[ ! -z $YUM_CMD ]]; then
    echo -e "Package manager is yum"
    yum install -yq curl jq zip
 elif [[ ! -z $APT_GET_CMD ]]; then
    echo -e "Package manager is apt-get"
    echo
    apt-get install -yq curl zip jq
 echo -e "error can't install packages"
    exit 1;
 fi
}

query_full(){
echo
echo -e "AWS instance metadata is:"
curl --silent -k http://169.254.169.254/latest/dynamic/instance-identity/document
echo
}

query(){
echo
echo -e "Key to be searched is = ${key}"
formatted=`curl --silent -k http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r ."${key}"`
echo
echo -e "Retrived value is = ${formatted}"
echo
}

prepare
query_full
query