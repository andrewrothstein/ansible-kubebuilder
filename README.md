andrewrothstein.kubebuilder
=========
![Build Status](https://github.com/andrewrothstein/ansible-kubebuilder/actions/workflows/build.yml/badge.svg)

Installs [kubebuilder](https://book.kubebuilder.io/)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.kubebuilder
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
