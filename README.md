Prerequisites:
- at least 6 virtual/physical nodes with
- Ubuntu (tested with 14.04.1 LTS) and
- ssh connection to all nodes (preferably with a key without passphrase)
- ansible (tested with 1.9.3)

Configuration:
- create an ansible host file which specifies the host names and groups of the nodes

Provided playbooks:
- RSS recipes
```
ansible-playbook -v -i <host-file> <playbook>.yml
```
Example
```
ansible-playbook -v -i hosts-emulab setup-recipes.yml
ansible-playbook -v -i hosts-emulab start-recipes.yml
# Manually use the service for a while before stopping
ansible-playbook -v -i hosts-emulab stop-recipes.yml
ansible-playbook -v -i hosts-emulab copy-log-recipes.yml
ansible-playbook -v -i hosts-emulab clean-recipes.yml
```

TODO
- Setup and start rss-recipes with jmeter
```
ansible-playbook -v -i <host-file> run-recipes-with-jmeter.yml
```
Example
```
ansible-playbook -v -i hosts-emulab run-recipes-with-jmeter.yml
```

TODO
- Setup and start rss-recipes with kieker
```
ansible-playbook -v -i <host-file> run-recipes-with-kieker.yml
```
Example
```
ansible-playbook -v -i hosts-emulab run-recipes-with-kieker.yml
```
