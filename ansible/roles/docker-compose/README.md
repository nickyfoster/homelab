Ansible Role Docker
=========

Ansible role for Docker compose installation on Debian family Linux servers.
Possibly will add more Linux distros in the future.

https://docs.docker.com/engine/installation/linux/debian/

Requirements
------------

- 64bit Debian / Ubuntu / CentOS
- ansible >=2.2.0.0
- clone this role into ~/ansible-roles

Role Variables
--------------

Example `defaults/main.yaml:`
```yaml
---
compose_arch: x86_64
version: v2.14.2
os_type: linux

```
Example Playbook
----------------

```yaml
---
- hosts: "{{ hosts | default('all') }}"
  user: "{{ user | default('ubuntu') }}"
  roles:
     - docker_compose
```

License
-------

BSD
