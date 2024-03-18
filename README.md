
### run_all.sh

```
vim run_all.sh

填入以下内容：
github_token
gist_id
```

### crontab 
```
crontab -e
0 0 * * * cd /home/ubuntu/cfProxyIpTest && bash run_all.sh >> logs/$(date +"%Y%m%d%H%M%S").log 2>&1
```