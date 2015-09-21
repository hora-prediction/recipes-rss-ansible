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
ansible-playbook -i hosts-emulab setup.yml
ansible-playbook -i hosts-emulab start.yml
ansible-playbook -i hosts-emulab stop.yml
ansible-playbook -i hosts-emulab copy-log.yml
ansible-playbook -i hosts-emulab clean.yml
```
