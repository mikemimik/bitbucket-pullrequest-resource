#!/usr/bin/env bash

read -r -d '' PAYLOAD << EOF
{ 
    "source": {
        "username":"mperrotte",
        "password":"d6LXNASykVQRHyT4GZkZ",
        "uri": "git@bitbucket.org:resolver/core-services.git",
        "project": "resolver",
        "repository": "core-services",
        "branch": "develop" \
    },
    "version": {
        "pr_id": "749",
        "branch":"feature/CORE-10270_exported-reports-not-filtered",
        "commit":"167e59c71366",
        "updated_at":"1519685872000"
    }
}
EOF


#ASSETS=$(cd "$(dirname "$0")" && pwd)
#echo $ASSETS

echo $PAYLOAD | ./assets/in /tmp/build/get
