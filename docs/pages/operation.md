# Operation
!!! warning
    Pay attention when you launch the `backup.yml` or `restore.yml` because playbook automatically _**stop and start**_ the container to _**keep all the data safe**_.

## Backup guide
### Requirements

#### On the allspark machine
- Have an allspark instance running

### Ansible Backup playbook

- Launch the playbook to make your backup, like:

```bash
ansible-playbook -i hosts backup.yml
```

!!! Note
    You can change the release destination (default: `/opt/allspark/backup`) like so:
    ```bash
    ansible-playbook -i hosts backup.yml --extra-vars 'allspark_backup_directory=/tmp/allspark_backup'
    ```

## Restore guide
### Requirements

#### On the allspark machine
- Have the same installation of your backup to be able to restore your release

!!! warning
    Pay attention:

    - A component disabled (on the allspark machine) won't be imported on restore
    - restore needs a running instance
    - Previous datas of the restored containers will be lost (and aligned on the backup ones)


### Ansible Restore playbook

- Launch the playbook Restore to make the restore

```bash
ansible-playbook -i hosts restore.yml
```

!!! Note
    You can launch a dry-run mode if you want to test your backup to restore, like so:
    ```bash
    ansible-playbook -i hosts restore.yml --extra-vars 'allspark_restore_dry_run=true'
    ```
