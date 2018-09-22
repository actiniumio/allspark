# Installation guide

## Requirements

### On the allspark machine
- Docker ( tested with version 18.06.0 )
- Copy your ssh key to the remote server (with an empty passphrase)

## Generate & Copy SSH Key
See the [here](https://www.ssh.com/ssh/copy-id)

### On the control machine
- Ansible ( tested with version 2.5.5 )

## Ansible playbook

If you are on to adapt the configuration see the [configuration pages](/configuration.md)

!!! warning
    For offline install, the images configuration must be the same on both end.

If you are on a migration see the [operation pages](/operation.md)

### Online install

- Change the hosts file to point to the allspark machine.

```bash
ansible-playbook -i hosts install.yml
```

!!! warning
    Before using the playbook, you need to be sure to have your deployment user in the wheel groups

At this point, you will be able to see component show up along with their access URL
at `ingress.YOUR_ROOT_DOMAIN`.

### Offline install
#### 0. On the online control machine

!!! note
    Change the `allspark_release_destination` and `allspark_release_tmp_directory` to point to somwhere with at least 10Go of free space

```bash tab="Bash"
ansible-playbook -i hosts release.yml
```

```ini tab="hosts"
[all]
localhost ansible_connection=ssh ansible_user=admin_devops
```

it will generate a `.tar.gz` file at `allspark_release_destination`.
This file needs to be copied along with the `group_vars`
directory to the offline allspark machine.

#### 1. On the offline allspark machine

- Import the `group_vars` directory and the release `.tar.gz`
- Set the `allspark_release_destination` in the `group_vars/all.yml` file to point to the release.
- Set the `allspark_release_tmp_directory` to point to somwhere with at least 10Go of free space

```bash tab="Bash"
ansible-playbook -i hosts setup.yml
ansible-playbook -i hosts install.yml
```

```ini tab="hosts"
[all]
localhost ansible_connection=ssh ansible_user=admin_devops
```

!!! warning
    This playbook does not setup the system yet. The release is packaged along with
    CentOS RPM dependencies as well as pip wheels, but you will however have to install them yourself.
