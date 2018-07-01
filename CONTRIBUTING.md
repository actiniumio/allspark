We use `vagrant` to test the Allspark single node environment.
You can see the [install nodes here](https://www.vagrantup.com/docs/installation/).
The box used is the `centos/7` one.
You can test modification using this vm like so :
```sh

# Run this once, vagrant will let you know if it needs updates
vagrant box add centos/7

# Create a virtual machine, run the install.yml playbook on it
# It currently needs to be online when running this command.
vagrant up

# Stop & destroy the VM
vagrant destroy -f

```
