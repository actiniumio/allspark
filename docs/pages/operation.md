!!! warning
    Pay attention when you launch the `backup.yml` or `restore.yml` because playbook automatically _**stop and start**_ the container to _**keep all the data safe**_.

# Backup guide
## Requirements

### On the allspark machine
- Have an allspark instance running

## Ansible Backup playbook

- Launch the playbook to make your backup, like:

```bash
ansible-playbook -i hosts backup.yml
```

!!! Note
    You can specify your backup repository by modify the `group_vars/all.yml`

    - Set the variable `allspark_backup_directory` to the desired value
    - By default the backup is stored on the local filesystem named: `/opt/allspark/backup`

# Restore guide
## Requirements

### On the allspark machine
- Have the same installation of your backup to be able to restore your release

!!! warning
    Pay attention:

    - A component disabled (on the allspark machine) won't be imported on restore
    - restore needs a running instance
    - Previous datas of the restored containers will be lost (and aligned on the backup ones)


## Ansible Restore playbook

- Launch the playbook Restore to make the restore

```bash
ansible-playbook -i hosts restore.yml
```

!!! Note
    - Modify the file `roles/backup/defaults/main.yml`
    - Set the variable `allspark_restore_dry_run` at `true` instead of `false`

You can launch a dry-run mode if you want to test your backup to restore, like:

```bash
ansible-playbook -i hosts restore.yml --extra-vars 'allspark_restore_dry_run=true'
```
