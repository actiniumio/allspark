# Contributing

## Development

### Docker images

The docker images are downloaded in the `download` role.
If you need to add an image to allspark, add the corresponding entry
in the `roles/download/defaults/main.yml` file. You can then refer to
your image using `{{ downloads.your_image.image }}:{{ downloads.your_image.tag }}`.


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
# Generate the virtualenv
make doc

# Switch the python runtime to the venv one
source .docs_venv/bin/activate

# Serve the documentation on http://localhost:8000
mkdocs serve
```
