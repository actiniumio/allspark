# Configuration

## Group_vars
- Edit the file `group_vars/all.yml` to fit with
your needs, like:
  - The `allspark_root_domain` to use your domain name
    (each component will be exposed as a subdomain).
  - The `allspark_docker_version` to choose the docker version you want.
  - Enable or disable component using their `enabled` boolean toggle.
  - Enable or disable certificates option using their `enable` boolean Toggle.
    - You can set all you want for the self-signed use.

```
allspark_monitoring:
  enabled: true

allspark_traefik:
  selfsigned:
    enabled: false
    # For example country: FR
    country: XX
    state: state
    location: city
    organisation: myteam
    organizational_unit: myorganizational_unit
    common_name: "*.{{ allspark_root_domain }}"
```

## Downloads

!!! note
    You can customize the image or tag for a component by overriding the `component_image` and `component_tag`, using either :

    - [Ansible extra vars](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#passing-variables-on-the-command-line)
    - Add those variables to your `group_vars/all.yml` file.

    _e.g_: gitlab

    ```yaml
       # Change gitlab-ce to gitlab-ee
       gitlab_image: gitlab_ee
       gitlab_tag: latest
    ```

    You can access the complete list of available components in the [roles/downloads/defaults/main.yml](https://github.com/TheFkinCompany/allspark/blob/master/roles/download/defaults/main.yml) file.
