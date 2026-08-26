#!/usr/bin/env bash

# Deve-se colar a cópia da tela do http://scvmm-dashboard.ebserh/ no arquivo do_scvmm-dashboard.ebserh.ini.
cat do_scvmm-dashboard.ebserh.txt |tr [[:upper:]] [[:lower:]] |grep -E '172\.|10\.' |awk '{print $1,"ansible_host="$(NF-2)}' >out
mv out scvmm.ini
