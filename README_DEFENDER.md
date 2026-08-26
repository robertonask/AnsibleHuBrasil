1. Execução
Na raiz do projeto:

ansible-playbook -i inventory.ini playbooks/defender.yml

2. Proxy corporativo (opcional)
No:
group_vars/all/main.yml
adicione:
mdatp_proxy: "http://proxy.empresa.local:8080"

3. Exclusões opcionais
Também no:
group_vars/all/main.yml
mdatp_exclusions:
  - /var/lib/docker
  - /u01/oracle
  - /var/lib/postgresql

4. Resultado esperado
Depois do playbook:
mdatp health

deve retornar algo parecido com:
healthy : true
licensed : true
real_time_protection_enabled : true


5. Validação rápida pós deploy
Você pode validar em lote:
ansible linux -i inventory.ini -m shell -a "mdatp health --field healthy"
Ou:
ansible linux -i inventory.ini -m shell -a "mdatp connectivity test"


6. Como rodar:

root@sede-dvl-apl1:~# ps -ef |grep mdatp
root     3564217       1  0 10:02 ?        00:00:09 /opt/microsoft/mdatp/sbin/wdavdaemon
root     3564252 3564217  0 10:02 ?        00:00:07 /opt/microsoft/mdatp/sbin/wdavdaemon edr 18 17 --log_level info
mdatp    3564401 3564217  0 10:02 ?        00:00:06 /opt/microsoft/mdatp/sbin/wdavdaemon unprivileged 24 26 28 30 23 --log_level info
ansible-playbook playbooks/defender.yml 

Criadas TAGS
rnask@nask:~/Trab/Ansible/ansible$ grep tags -A2 roles/defender/tasks/main.yml 
  tags:
    - defender
    - install
--
  tags:
    - defender
    - repo
--
  tags:
    - defender
    - repo
--
  tags:
    - defender
    - repo
--
  tags:
    - defender
    - repo
--
  tags:
    - defender
    - install
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - onboarding
--
  tags:
    - defender
    - proxy
--
  tags:
    - defender
    - exclusions
--
  tags:
    - defender
    - exclusions
--
  tags:
    - defender
    - realtime
--
  tags:
    - defender
    - realtime
--
  tags:
    - defender
    - service
--
  tags:
    - defender
    - service
--
  tags:
    - defender
    - validation
--
  tags:
    - defender
    - validation
--
  tags:
    - defender
    - validation
--
  tags:
    - defender
    - validation
--
  tags:
    - defender
    - validation
--
  tags:
    - defender
    - validation


Utilizando tags:
rnask@nask:~/Trab/Ansible/ansible$ ansible-playbook playbooks/defender.yml --tags onboarding

PLAY [Instalar Microsoft Defender Endpoint] ***************************************************

TASK [Gathering Facts] ************************************************************************
ok: [sede-dvl-apl1]

TASK [defender : Copiar onboarding package] ***************************************************
ok: [sede-dvl-apl1]

TASK [defender : Criar diretório temporário] **************************************************
ok: [sede-dvl-apl1]

TASK [defender : Extrair onboarding package] **************************************************
ok: [sede-dvl-apl1]

TASK [defender : Encontrar script onboarding] *************************************************
ok: [sede-dvl-apl1]

TASK [defender : Verificar status atual] ******************************************************
ok: [sede-dvl-apl1]

TASK [defender : Executar onboarding] *********************************************************
skipping: [sede-dvl-apl1]

PLAY RECAP ************************************************************************************
sede-dvl-apl1              : ok=6    changed=0    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0   

rnask@nask:~/Trab/Ansible/ansible$ ansible-playbook -i inventory.ini playbooks/defender.yml --syntax-check

playbook: playbooks/defender.yml
rnask@nask:~/Trab/Ansible/ansible$ 

