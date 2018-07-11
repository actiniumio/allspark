# Troubleshooting

## Install
---

- ```TypeError: create_host_config() got an unexpected keyword argument 'init'``` (using verbose ansible mode)
> The issue is caused by incompatible `docker-py` and `docker` python libraries versions. See [This ansible issue](https://github.com/ansible/ansible/issues/42162) for more details.
An easy fix being to downgrade your ansible install to `v2.5.5`.
