puppet-analytics-client
=======================

An place to store clients for posting module statistics to puppet-analytics.org. Probably should have made it plural. Live and learn.



puppet-analytics-client.sh
--------------------------


Example use of puppet-analytics-client.sh, given that you are on the puppetmaster or have set the correct environment variables. Note that puppet-analytics-client requires jq, the shell jason tool. It is available on precise and trusty.


```shell
./puppet-analytics-client.sh
```




raw curl
--------


```shell
curl -XPOST 'puppet-analytics.org/api/1/module_send' -H "Content-Type: application/json" -d '{
"author": "nibalizer",
"name": "puppetboard",
"tags": "version=1.0,purpose=test"
}'
```




post-commit
-----------


For my personal systems, I simply have a git directory in /etc/puppet/manifests that I use to control site.pp. I put an executable post-commit file in .git/hooks with the content:

```shell
/path/to/puppet-analytics-client.sh
```

And every time I git-commit, a fresh listing of my modules is sent up to puppet-analytics.




