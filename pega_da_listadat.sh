#!/usr/bin/env bash

cat /home/rnask/Trab/scripts/dados_comuns/lista.dat |awk -F\; '{print $1," ansible_host="$2}' > total_inventory.ini 
sed -i 's/\-postgresql/\-pg1/g' total_inventory.ini
sed -i 's/\-postgresql1/\-pg1/g' total_inventory.ini
sed -i 's/\-pg\-master/\-pg1/g' total_inventory.ini
sed -i 's/\-pg\-slave/\-pg2/g' total_inventory.ini
sed -i 's/\-apache/\-apr/g' total_inventory.ini
sed -i 's/\-wildfly/\-apl/g' total_inventory.ini
sed -i 's/\-proxy1/\-prx1/g' total_inventory.ini
sed -i 's/\-docker1/\-dck1/g' total_inventory.ini
sed -i 's/\-cups/\-prt1/g' total_inventory.ini
sed -i 's/\-cups1/\-prt1/g' total_inventory.ini
sed -i 's/\-cups2/\-prt2/g' total_inventory.ini
