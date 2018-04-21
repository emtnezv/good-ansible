# good-ansible


#Overview

Good Ansible is a "Good" version of the repo `bad-ansible` used for training purposes.

. Env Files and Settings

Inventory file hosts, ssh.cfg reflect a particular lab environment and this will need modified to be used elsewhere.

#ssh.cfg

This, optional, configuration file assumes the use of a `bastion` or `local laptop`
and in some environments will be unnecessary or alternatively the `~/.ssh/config`
 or equivalent should be used.

`ansible.cfg` references `ssh.cfg`.

## provision.sh

This script was provided to simplify usually operations, and configurations.

`provision.sh provision-all:` Install all layers of infrastructure.

`provision.sh clear-all:` Remove all layers of infrastructure.

`provision.sh haproxy:` Install haproxy in frontend node

`provision.sh tomcat:` Install and configure tomcat in app-servers nodes

`provision.sh database:` Install and configure postgresql in db-node node

`provision.sh tests:` Apply tests over frontend and app-servers

## secret

Some files were protected with vault, so a password is need during the script execution.

provision.sh provision-all <password>
