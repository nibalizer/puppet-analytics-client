puppet-analytics-client
=======================

An example client for posting module statistics to puppet-analytics.org


Example curl:

```shell
curl -XPOST 'puppet-analytics.org/api/1/module_send' -H "Content-Type: application/json" -d '{
"author": "nibalizer",
"name": "puppetboard",
"tags": "version=1.0,purpose=test"
}'
