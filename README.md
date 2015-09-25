Prerequisites:
- at least 6 virtual/physical nodes with
- Ubuntu (tested with 14.04.1 LTS) and
- ssh connection to all nodes (preferably with a key without passphrase)
- ansible (tested with 1.9.3)

Configuration:
- create an ansible host file which specifies the host names and groups of the nodes
- set parameters in group_vars/all

Usage:
```
ansible-playbook -i <host-file> <playbook>.yml
```
Example
```
ansible-playbook -i hosts setup.yml
ansible-playbook -i hosts start.yml
ansible-playbook -i hosts stop.yml
ansible-playbook -i hosts copy-log.yml
ansible-playbook -i hosts clean.yml
```
