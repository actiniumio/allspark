# Troubleshooting

## Install
---

- ```TypeError: create_host_config() got an unexpected keyword argument 'init'``` (using verbose ansible mode)
> The issue is caused by incompatible `docker-py` and `docker` python libraries versions. See [This ansible issue](https://github.com/ansible/ansible/issues/42162) for more details.
An easy fix being to downgrade your ansible install to `v2.5.5`.

## Gitlab
---

   ```bash tab="Issuer certificate is invalid"

   $ git config --global http.sslVerify true
   $ git clone http://gitlab.allspark.domainename/root/test.git
   Cloning into 'test'...
   fatal: unable to access 'http://gitlab.allspark. domainename/root/test.git/': Issuer certificate is invalid.

   $ git config --global http.sslVerify false
   $ git clone https://gitlab.allspark.localhost/root/test.git
   ```
