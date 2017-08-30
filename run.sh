#!/bin/bash

IP=127.0.0.1:8083
curl -D /tmp/headers.txt -s -o /dev/null  -w "%{http_code}" -d "username=jordan&password=password" -H "Content-Type: application/x-www-form-urlencoded" -XPOST "http://$IP/doorman/rest/login"
Authorization=`cat /tmp/headers.txt | grep "Authorization" | awk '{print $2,$3}'`
echo "login status: $http_code"
if [ -z "$Authorization" ];then
  echo " get token failed"
  exit 0
fi

while true;
do
  #echo "getting fibonacci number"
  NUMBER=`curl -s -H "Authorization: $Authorization" -XGET "http://$IP/beekeeper/rest/queen/ancestors/1"`
  echo $NUMBER
  #FIBONA_NUM=`curl -H "Authorization: $Authorization" -XGET "http://$IP/worker/fibonacci/term?n=1"`
  if [ -z "$NUMBER" ];then
    echo "Failed to handle"
    exit 1
  fi
  #echo "OK"
done

