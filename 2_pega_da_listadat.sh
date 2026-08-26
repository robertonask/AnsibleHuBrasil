#!/usr/bin/env bash

echo [debian] > inventory.ini
awk -F \, '{print $2,"ansible_host="$18}' /home/rnask/Trab/scripts/listadat/vms_export/SCVMM_VMs_Current.csv |tr '[:upper:]' '[:lower:]'|tr -d \"|grep -E '10\.|172.' >>inventory.ini

