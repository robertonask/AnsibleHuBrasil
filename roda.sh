#!/usr/bin/env

set -x 
#ansible-playbook playbooks/repo.yml -i inventory.ini -l webservers --vault-password-file ~/.vault_pass.txt
ansible-playbook playbooks/repo.yml -i inventory.ini -l all --vault-password-file ~/.vault_pass.txt
