#!/bin/bash


HOST=local

REALM=${1:-$REALM}
set -a; source ../envs/.env-$REALM; set +a
TEST_USERNAME=${2:-hello@$EMAIL_DOMAIN}
TEST_PASSWORD=${3:-$EMAIL_PASSWORD}

#echo $HOST
#echo $REALM
#echo $AUTH_OPENID_CLIENT_ID
#echo $TEST_USERNAME
#echo $TEST_PASSWORD

if [ "$REALM" == 'panta' ]; then
  TEST_USERNAME=hello@pantagroup.org
fi

if [ "$HOST" == 'local' ]; then
    #AUTH_BASE_URL=$LOCAL_AUTH_BASE_URL 
    AUTH_BASE_URL=$PUBLIC_AUTH_BASE_URL 
fi

if [ "$HOST" == 'production' ] || [ "$HOST" == 'prod' ]; then
    AUTH_BASE_URL=$PUBLIC_AUTH_BASE_URL 
fi



if [ "$HOST" == 'docker' ]; then
  CMD='curl -s -k -X POST "'${AUTH_BASE_URL}'/realms/'${REALM}'/protocol/openid-connect/token"  -H "Content-Type: application/x-www-form-urlencoded" -d "username='${TEST_USERNAME}'" -d "password='${TEST_PASSWORD}'" -d "grant_type=password" -d "client_id='${AUTH_OPENID_CLIENT_ID}'"  -d "client_secret='${AUTH_OPENID_CLIENT_SECRET}'"'
#`echo $CMD

#KEYCLOAK_RESPONSE=`echo "$CMD" |  docker exec --interactive $PROJECTx /bin/bash -`

KEYCLOAK_RESPONSE=`curl -s -k -X GET http://localhost/token`
else

if [ "$HOST" == 'local' ]; then

  KEYCLOAK_RESPONSE=`curl -s -X POST "https://${AUTH_BASE_URL}/realms/${REALM}/protocol/openid-connect/token"  -H "Content-Type: application/x-www-form-urlencoded" -d "username=${TEST_USERNAME}" -d "password=${TEST_PASSWORD}" -d 'grant_type=password' -d "client_id=${AUTH_OPENID_CLIENT_ID}"  -d "client_secret=${AUTH_OPENID_CLIENT_SECRET}"`
fi
if [ "$HOST" == 'production' ] || [ "$HOST" == 'prod' ]; then
#echo $PUBLIC_AUTH_BASE_URL
  KEYCLOAK_RESPONSE=`curl -s -X POST "https://${AUTH_BASE_URL}/realms/${REALM}/protocol/openid-connect/token"  -H "Content-Type: application/x-www-form-urlencoded" -d "username=${TEST_USERNAME}" -d "password=${TEST_PASSWORD}" -d 'grant_type=password' -d "client_id=${AUTH_OPENID_CLIENT_ID}"  -d "client_secret=${AUTH_OPENID_CLIENT_SECRET}"`
#echo $KEYCLOAK_RESPONSE

fi

fi

ACCESS_TOKEN=`echo "$KEYCLOAK_RESPONSE" | jq -r '.access_token'`

#echo "HOST            : $HOST"
#echo "REALM           :  $REALM"
#echo "AUTH_BASE_URL   :  $AUTH_BASE_URL"
#echo "AUTH_OPENID_CLIENT_ID   :  $AUTH_OPENID_CLIENT_ID"
#echo "TEST_USERNAME   :  $TEST_USERNAME"
#echo "TEST_PASSWORD   :  $TEST_PASSWORD"
echo $ACCESS_TOKEN
