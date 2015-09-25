# Netflix's RSS recipes with Ansible
This setup provides ansible playbooks to run Netflix's distributed RSS recipes (https://github.com/hora-prediction/recipes-rss.git).

## System requirements
- 6 virtual/physical nodes and one control node (e.g. your laptop)
- Ubuntu installed on all nodes (tested with 14.04.1 LTS)
- ssh connection from control node to all nodes (preferably with a key without passphrase)
- all nodes must be able to communication with each other by hostname
- ansible installed on control node (tested with 1.9.3)

## Configuration
- create an ansible host file ```hosts``` which specifies the hostnames and groups of the nodes
- (optional) set parameters in ```group_vars/all```

## Instruction

### How to run RSS recipes
Ansible playbooks can be executed by
```ansible-playbook -i <host-file> <playbook>.yml```

Example:
- ```ansible-playbook -i hosts setup.yml``` installs the required packages on the nodes and sets up the RSS recipes including Kieker (if enabled in ```group_vars/all```)
- ```ansible-playbook -i hosts start.yml``` starts all services of all nodes including RSS recipes and Kieker
- ```ansible-playbook -i hosts stop.yml``` stops all services
- ```ansible-playbook -i hosts copy-log.yml``` copies the log files of all nodes to the node where this command is executed
- ```ansible-playbook -i hosts clean.yml``` deletes all log files of all nodes

### Using the application
0. The RSS reader service can be accessed at http://<edge>/jsp/rss.jsp from the host machine.
0. Add RSS feeds from the following URLs:
   - http://<rssserver>/feeds/abc.xml
   - http://<rssserver>/feeds/bbc.xml
   - http://<rssserver>/feeds/cnn.xml
   - http://<rssserver>/feeds/dw.xml
   - http://<rssserver>/feeds/forbes.xml
   - http://<rssserver>/feeds/reuters.xml
   - http://<rssserver>/feeds/spiegel.xml
   - http://<rssserver>/feeds/wsj.xml
0. The feeds can be removed by clicking the delete icon.

## Architecture of RSS recipes


        +------------+      +------------+      +------------+      +------------+ 
     :80|loadbalancer| :9090|    edge    | :9191| middletier | :9160|  database  | 
     -->|            |----->|            |----->|            |----->|            | 
        +------------+      +------------+      +------------+      +------------+ 
                                    \               /    \                         
                                     \             /      \                        
                                      \:80        /:80     \:80                    
                                       \         /          \                      
                                     +------------+         +------------+         
                                     |   Eureka   |         | Feed server|         
                                     |            |         |            |         
                                     +------------+         +------------+         

## How to scale the application
0. Prepare more nodes
0. Add nodes to the host file ```hosts```
0. Execute ansible playbooks
