# Configuration

## Group_vars
- Edit the file `group_vars/all.yml` to fit with
your needs, like:
  - The `allspark_root_domain` to use your domain name
    (each component will be exposed as a subdomain).
  - The `allspark_docker_version` to choose the docker version you want.
  - Enable or disable component using their `enabled` boolean toggle.

```yaml
allspark_monitoring:
  enabled: true
```

### HTTPS

In order to provide HTTPS, you can either :

- Enable self signed certificates by activating the `allspark_haproxy.ssl.enabled` and `allspark_haproxy.ssl.selfsigned.enabled` flags.
- Import a certificate from your control machine : enable `allspark_haproxy.ssl.enabled`,
set the `allspark_haproxy.ssl.certificates_directory` variable to a folder on the control machine
containing PEM certificates named like their endpoint (e.g: `infra.allspark.localhost.pem`)

You can also do a mix of both, imported certificates will be picked over generated ones,
allowing you to import certificates for some of the endpoints and let Allspark generate
the missing ones.

!!! note
    For wildcard and UCC certificates signing multiple domains, simply copy the file (or create a symbolic link pointing to it) to mirror the new endpoint
    e.g:
    ```sh
    cp infra.allspark.localhost.pem chat.allspark.localhost
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

    You can access the complete list of available components in the [roles/downloads/defaults/main.yml](https://github.com/actiniumio/allspark/blob/master/roles/download/defaults/main.yml) file.
