#!/bin/bash

USER=${MONGODB_USER:-"admin"}
DATABASE=${MONGODB_DATABASE:-"admin"}
PASS=${MONGODB_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MONGODB_PASS} ] && echo "preset" || echo "random" )

# ps aux |grep mongod

echo "########################################################"
echo ${USER}
echo ${DATABASE}
echo ${PASS}
echo ${_word}

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

# ps -aux |grep mongod

NUM=`ps -aux |grep mongod |awk '{print $4}'`

echo "returnnum: ${NUM}"
kill ${num}
# ps -aux |grep mongod |awk '{print $4}' |kill

# mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE --replSet rs0"
#
# $mongodb_cmd &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 5
    mongo admin --eval "help" >/dev/null 2>&1
    RET=$?
done

echo "=> Creating an ${USER} user with a ${_word} password in MongoDB"
mongo admin --eval "db.createUser({user: '$USER', pwd: '$PASS', roles:[{role:'root',db:'admin'}]});"

if [ "$DATABASE" != "admin" ]; then
    echo "=> Creating an ${USER} user with a ${_word} password in MongoDB"
    mongo admin -u $USER -p $PASS << EOF
use $DATABASE
db.createUser({user: '$USER', pwd: '$PASS', roles:[{role:'dbOwner',db:'$DATABASE'}]})
EOF
fi



mongo admin -u $USER -p $PASS << EOF
use admin
db.createUser({user: 'clusterAdmin', pwd: 'wozhiaini070507', roles:[{role:'clusterManager',db:'admin'},{role:'readAnyDatabase',db:'admin'}]})
EOF

mongo admin -u $USER -p $PASS << EOF
use lqiong
db.createUser({user: 'rang', pwd: 'wozhiaini070507', roles:[{role:'readWrite',db:'lqiong'}]})
EOF

mongo admin -u $USER -p $PASS << EOF
use local
rs.initiate()
EOF

mongo admin -u $USER -p $PASS << EOF
use local
rs.status()
EOF

echo "=> Done!"
touch /data/db/.mongodb_password_set

echo "========================================================================"
echo "You can now connect to this MongoDB server using:"
echo ""
echo "    mongo $DATABASE -u $USER -p $PASS --host <host> --port <port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
