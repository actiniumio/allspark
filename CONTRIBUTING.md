# Contributing

## Development

### Ansible Lint
Actually, you need to edit `.circleci/.config.yml` if you add a main core playbook for allspark

_e.g_:
```yaml
 - run: PATH=$PATH:/root/.local/bin ansible-lint mynewplaybook.yml -c .circleci/.ansible-lint
```

### OS Compatibility

To add an OS compatibility
  - you need to add a valid yml on folder roles/system/tasks
<<<<<<< HEAD
  - you need to named him like : "{{ ansible_distribution }}-{{ ansible_distribution_major_version}}.yml"
  - for exemple:
=======
  - you need to named it like : "{{ ansible_distribution }}-{{ ansible_distribution_major_version}}.yml"
  - for example:
>>>>>>> 41f76a5... Update Contributing
    - Ubuntu-14.yml
    - CentOS-7.yml
  - you need to edit the Makefile, add you os like:
    ```
       test-<osmajorversion>:
       vagrant up <osmajorversion> --provision
    ```
  - you need to edit the Vagrantfile
    ```
    config.vm.define "<osmajorversion>", autostart: false do |<osmajorversion>|
      ubuntu14.vm.box = "actinium/<osmajorversion>"
      ubuntu14.vm.network "forwarded_port", guest: 80, host: 8081, host_ip: "127.0.0.1"
      ubuntu14.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
      end
      ubuntu14.vm.provision "ansible" do |ansible|
        ansible.verbose = "vvv"
        ansible.playbook = "install.yml"
      end
    end
    ```
  - you need to validate it via vagrant

<<<<<<< HEAD
if you don't found a box to test your compatibility, send a mail to ```bot.actinium@gmail.com```
=======
>For the Red Hat Enterprise Linux, only the actinium team could validate the playbook

>If you don't found a box to test your compatibility, you can contribute [Here](https://app.vagrantup.com/actinium/)
>>>>>>> 41f76a5... Update Contributing

### Docker images

The docker images are downloaded in the `download` role.
If you need to add an image to allspark, add the corresponding entry
in the `roles/download/defaults/main.yml` file. You can then refer to
your image using `{{ downloads.component_name.image }}:{{ downloads.component_name.tag }}`.

By convention, the image `name` and `tag` are exposed in separated variables `${component_name}_image` and `${component_name}_tag`.

_e.g_:
```yaml
# Images
gitlab_image: gitlab/gitlab-ce

# Tags
gitlab_tag: latest

# Downloads
downloads:
  gitlab:
    enabled: "{{ allspark_gitlab.enabled }}"
    image: "{{ gitlab_image }}"
    tag: "{{ gitlab_tag }}"
```

This format is helful to centralize `downloads` for an easier access in roles, the exposed variables also allow the user to
easily override an image/tag with a `ansible-playbook -e "${component_name}_image=my-image"`


## Test modifications

We use `vagrant` to test the Allspark single node environment.
You can see the [install notes here](https://www.vagrantup.com/docs/installation/).
The box used is the `centos/7` one.
You can test modification using Vagrant like so :
```sh

# Run this once, vagrant will let you know if it needs updates
vagrant box add centos/7

# Create a virtual machine, run the install.yml playbook on it
# It needs to be online when running this command.
make test

# Stop & destroy the VM
make clean
```

## Documentation

### Build
You can build the documetation using the `make doc` command. The resulting artifacts will be stored in the `doc` directory.
To view the resulting docs, you can use any http server, like :
```sh
# Python3
python3 -m http.server

# Python2
python2 -m SimpleHTTPServer
```

### Hot reload
If you want to review your work while editing, you can use :
```sh
# Serve the documentation on http://localhost:8000
make doc-dev
```
