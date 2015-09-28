# Netflix's RSS recipes with Ansible
This setup provides ansible playbooks to run Netflix's distributed RSS reader application (https://github.com/hora-prediction/recipes-rss.git). Ansible automates the provisioning of the nodes, i.e., installing required packages, downloading, compiling and configuring the application, instrumenting the application with Kieker, starting and stopping the application, etc.

## Architecture of RSS recipes

        +------------+      +------------+        +------------+        +------------+ 
     :80|loadbalancer| :9090|    edge    |+  :9191| middletier |+  :9160|  database  | 
     -->|            |----->|            ||+----->|            ||+----->|            | 
        +------------+      +------------+||      +------------+||      +------------+ 
                             +------------+|       +------------+|
                              +------------+        +------------+
                                         \             /      \                        
                                          \           /        \                    
                                           \:80      /:80       \:80
                                         +------------+         +------------+         
                                         |   Eureka   |         | RSS server |         
                                         |            |         |            |         
                                         +------------+         +------------+         

## System requirements
- at least 6 virtual/physical nodes and one control node (e.g. your laptop)
- Ubuntu (>= 14.04.1 LTS) installed on all nodes
- ansible (>= 1.9.3) installed on control node
- ssh connection from control node to all nodes (preferably with a key without passphrase)
- all nodes must be able to communication with each other by hostname

The application can also run on one machine using VirtualBox. Please refer to https://github.com/hora-prediction/recipes-rss-vagrant-ansible for more information.

## Configuration
- create an ansible host file ```hosts``` which specifies the hostnames and groups of the nodes
- (optional) set parameters in ```group_vars/all```

## Instruction

### How to run RSS recipes
Ansible playbooks can be executed from the control node with ```ansible-playbook -i <host-file> <playbook>.yml```

Example:
- ```ansible-playbook -i hosts setup.yml``` installs the required packages on the nodes and sets up the RSS recipes including Kieker (if enabled in ```group_vars/all```)
- ```ansible-playbook -i hosts start.yml``` starts all services of all nodes including RSS recipes and Kieker
- ```ansible-playbook -i hosts stop.yml``` stops all services
- ```ansible-playbook -i hosts copy-log.yml``` copies the log files of all nodes to the node where this command is executed
- ```ansible-playbook -i hosts clean.yml``` deletes all log files of all nodes

### Using the application
0. The RSS reader service can be accessed at http://edge.hostname/jsp/rss.jsp.
0. Add RSS feeds from the following URLs:
   - http://rssserver.hostname/feeds/abc.xml
   - http://rssserver.hostname/feeds/bbc.xml
   - http://rssserver.hostname/feeds/cnn.xml
   - http://rssserver.hostname/feeds/dw.xml
   - http://rssserver.hostname/feeds/forbes.xml
   - http://rssserver.hostname/feeds/reuters.xml
   - http://rssserver.hostname/feeds/spiegel.xml
   - http://rssserver.hostname/feeds/wsj.xml
0. The feeds can be removed by clicking the delete icon.

## How to scale the application
The application allows horizontal scaling of the edge and middletier. This can be done by:

0. Add new nodes to the corresponding groups in the host file ```hosts```
0. Execute ansible playbooks
