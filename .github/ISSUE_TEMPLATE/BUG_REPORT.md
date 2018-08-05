---
name: Bug report
about: Report us a bug

---

---
### Describe the bug

> A clear and concise description of what the bug is.

---
### Reproduction scenario

> **note**: You might want to use the Vagrant environment to create a reproducible scenario triggering the bug.

Steps to reproduce the behaviour:

1. ...
2. ...

---
### Expected behaviour

> A clear and concise description of what you expected to happen.

---
### Allspark informations

> Informations about the control and allspark machines.

- **Allspark**
  - *version*

```
output of `git rev-parse HEAD`
```

  - *configuration*

```yaml
# allspark group_vars/* configurations
```

- **Control machine**
  - *Operating system* :

```
output of `uname -a`
```

  - *Ansible version* :

```
output of `ansible --version`
```

  - *Vagrant version* (if used to reproduce the issue) :

```
output of `vagrant version`
```

- **Allspark server**
  - *Operating system* :

```
output of `uname -a`
```

  - *Docker version* :

```
output of `docker version`
```

---
### Additional context

> Add any other informations about the problem here. (e.g: logs, screenshots)
