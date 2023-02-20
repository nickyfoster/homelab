Ansible Role Docker
=========

Ansible role for Docker installation on Debian family Linux servers.
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
docker_repo_base_url: https://download.docker.com/linux

host_user: ubuntu

```
Example Playbook
----------------

```yaml
---
- hosts: "{{ hosts | default('all') }}"
  user: "{{ user | default('ubuntu') }}"
  roles:
     - docker
```

License
-------

BSD
