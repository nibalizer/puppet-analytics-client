#!/bin/bash

echo "Starting Puppet Analytics Run"

PA_SERVER=${PUPPET_ANALYTICS_SERVER:-http://puppet-analytics.org}
PA_API_VER=${PUPPET_ANALYTICS_API_VER:-1}
PA_ENVIRONMENT=${PUPPET_ANALYTICS_ENVIRONMENT:-production}
PA_MODULEPATH=${PUPPET_ANALYTICS_MODULEPATH:-/etc/puppet/modules:/etc/puppet/environments/${PA_ENVIRONMENT}/modules}

if [ -z $PUPPET_ANALYTICS_PURPOSE ]; then
    if [ "$PA_ENVIRONMENT" = "production" ] ; then
        PA_PURPOSE='production'
    else
        PA_PURPOSE='test'
    fi
else
    PA_PURPOSE=${PUPPET_ANALYTICS_PURPOSE}
fi

echo PA_SERVER: $PA_SERVER
echo PA_API_VER: $PA_API_VER
echo ENVIRONMENT: $PA_ENVIRONMENT
echo MODULEPATH: $PA_MODULEPATH

for moduledir in ${PA_MODULEPATH//:/ } ; do
    if [ -d $moduledir ]; then
        for metadatafile in `ls $moduledir/*/metadata.json` ; do
            name=`cat $metadatafile | jq '. name' | tr -d '"' | sed 's/\//-/'`
            version=`cat $metadatafile | jq '. version' | tr -d '"'`
            author=`echo $name| cut -d "-" -f 1`
            modulename=`echo $name| cut -d "-" -f 2`

            echo curl -XPOST "${PA_SERVER}/api/1/module_send" -H "Content-Type: application/json" -d "'{
            \"author\": \"$author\",
            \"name\": \"$modulename\",
            \"tags\": \"version=$version,purpose=$PA_PURPOSE\"
            }'"

        done

    fi

done

