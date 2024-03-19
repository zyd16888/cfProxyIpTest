
### run_all.sh

```
vim script/update_gist.sh

填入以下内容：
github_token
gist_id
```

### crontab 
```
crontab -e
0 0 * * * /usr/bin/bash /home/ubuntu/cfProxyIpTest/script/crontab_run.sh
```