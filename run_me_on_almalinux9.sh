#!/bin/bash

sudo modprobe ip_tables
sudo echo 'ip_tables' >> /etc/modules

# see details in https://github.com/wg-easy/wg-easy/issues/827
