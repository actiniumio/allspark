# Backup guide
## Requirements

### On the allspark machine
- Docker ( tested with version 18.04 )
- Have an allspark instance running

## Ansible Backup playbook

- Launch the playbook Backup to make your backup, like:

```bash
ansible-playbook -i hosts backup.yml
```

!!! Note
    You can specify your backup repository by modify `the group_vars/all.yml`

    - Put the variable `allspark_backup_directory` on the to the desired value
    - By default the backup is store on the local filesystem named: `/opt/allspark/backup`

# Restore guide
## Requirements

### On the allspark machine
- Docker ( tested with version 18.04 )
- Have the same installation of your backup to be able to restore your release

!!! warning
    Pay attention you cannot use the restore without a fresh install identical as you backup 

## Ansible Restore playbook

- Launch the playbook Restore to make the restore

```bash
ansible-playbook -i hosts restore.yml
```

!!! Note
    - Modify the file `roles/backup/defaults/main.yml`
    - Put the variable `allspark_restore_dry_run` at `true` instead of `false`

You can launch a dry-run mode if you want to test your backup to restore, like:

```bash
ansible-playbook -i hosts restore.yml
```

!!! warning
    Pay attention when you launch the `backup.yml` or `restore.yml` because playbook automatically stop and start the container to keep all the data safe.
