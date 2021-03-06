#!/bin/bash
set -m

mongodb_cmd="mongod --storageEngine $STORAGE_ENGINE " ##--replSet rs0" ##
cmd="$mongodb_cmd --httpinterface --rest --master"
if [ "$AUTH" == "yes" ]; then
    cmd="$cmd --auth"
fi

if [ "$JOURNALING" == "no" ]; then
    cmd="$cmd --nojournal"
fi

if [ "$OPLOG_SIZE" != "" ]; then
    cmd="$cmd --oplogSize $OPLOG_SIZE"
fi

$cmd &

if [ ! -f /data/db/.mongodb_password_set ]; then
    /set_mongodb_password.sh

    mongo-connector -m mongodb://clusterAdmin:wozhiaini070507@localhost:27017 -t  $SOLORURL -d solr_doc_manager -n lqiong.post,lqiong.topic --auto-commit-interval=0  --unique-key=id
fi

# http://106.75.133.18:8983/solr/zuijin

# fg
