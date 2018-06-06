# Allspark installer

This installer use ansible to setup Allspark on linux environment using Docker.
It deploy the solution using Docker 18.04

## Playbooks

- `release.yml`

> Package an Allspark release in a `.tar.gz` file

- `setup.yml`

> Load a packaged Allspark release into the system

- `install.yml`

> Install Allspark on the machine (either with an internet access or after using `setup.yml` playbook)


## Install from an Allspark release

- Download an Allspark release (in `.tar.gz` format)
- Edit the file `allspark/defaults/main.yml` of this project
  - Change the `allspark_root_domain` to use your domain name
    (each component will be exposed as a subdomain).
  - Change the `allspark_release_destination` to point to your downloaded release
  - Change the `allspark_release_tmp_directory` to point to somwhere with at least 10Go of free space
  - Optionnal: Enable or disable component using their `enabled` boolean toggle
- `ansible-playbook setup.yml`
- `ansible-playbook install.yml`

> Warning: This playbook does not setup the system yet. The release is packaged along with
CentOS RPM dependencies as well as pip wheels, but you will however have to install them yourself.

At this point, you will be able to see component show up along with their access URL
at `ingress.YOUR_ROOT_DOMAIN`.

## Components

| Components    | Usage                             |
| ------------- | --------------------------------- |
| Gitlab        | Source code management            |
|               | Continuous integration / delivery |
|               | Work planning                     |
|               | Issue tracking                    |
| Portainer     | Container management              |
| RocketChat    | Instant chat (Slack like)         |
| Grafana       | Monitoring                        |
| Prometheus    | Metrics scraping / store          |
| CAdvisor      | Container metrics                 |
| Node exporter | System metrics                    |
| Traefik       | Dynamic reverse proxy             |


# Requirements

- Linux using Docker
- 12Gb of ram
