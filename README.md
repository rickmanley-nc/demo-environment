# Using Ansible to Configure Demo Environment on Laptop - SA

## Requirements and General Steps
- Laptop needs to be configured via https://www.github.com/rickmanley-nc/laptop-configure
- Download RHEL 7 Server ISO (update laptop-configure role with directory /home/rnelson/Images/ISOS)
- `cd /home/rnelson/git`
- `git clone git@github.com:rickmanley-nc/demo-environment.git`
- `cd /home/rnelson/git/demo-environment`
- Modify the following files with the correct variables for your environment
  - /home/rnelson/git/demo-environment/group_vars/all
  - /home/rnelson/git/demo-environment/roles/install-satellite/vars/main.yml (This uses Ansible Vault)
  - /home/rnelson/git/demo-environment/roles/install-tower/vars/main.yml (This uses Ansible Vault)
- `ansible-playbook -i "localhost," -c local clone-from-template.yml -t tower`
- `ansible-playbook -i "localhost," -c local install-and-configure.yml -t tower`


## Roles


## Vars

- Most variables are located in `group_vars/all`.
- Activation Key and Org ID located in specific 'roles/install/vars/main.yml'

## Tags


## Remaining Items to Complete

- Fix Tower deploy and install
- Dropbox for hosting large files like ISOs?
- Use tower CLI to create projects, inventories, etc
- update readme for general steps of Tower setup
- update readme for roles
- update readme for tags

## License

Red Hat, the Shadowman logo, Ansible, and Ansible Tower are trademarks or registered trademarks of Red Hat, Inc. or its subsidiaries in the United States and other countries.

All other parts of this project are made available under the terms of the [MIT License](LICENSE).
