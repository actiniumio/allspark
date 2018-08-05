# Troubleshooting

## Install
---

- ```TypeError: create_host_config() got an unexpected keyword argument 'init'``` (using verbose ansible mode)
> The issue is caused by incompatible `docker-py` and `docker` python libraries versions. See [This ansible issue](https://github.com/ansible/ansible/issues/42162) for more details.
An easy fix being to downgrade your ansible install to `v2.5.5`.

## Gitlab
---

   ```bash tab="Issuer certificate is invalid"

   [root@allspark ~]# git config --global http.sslVerify true
   [root@allspark ~]# git clone http://gitlab.allspark.domainename/root/test.git
   Cloning into 'test'...
   fatal: unable to access 'http://gitlab.allspark. domainename/root/test.git/': Issuer certificate is invalid.

   [root@localhost allspark]# git config --global http.sslVerify false
   [root@localhost allspark]# git clone https://gitlab.allspark.localhost/root/test.git
   Cloning into 'test'...
   Username for 'https://gitlab.allspark.localhost': root
   Password for 'https://root@gitlab.allspark.localhost':
   remote: Counting objects: 3, done.
   remote: Total 3 (delta 0), reused 0 (delta 0)
   Unpacking objects: 100% (3/3), done.
   ```
