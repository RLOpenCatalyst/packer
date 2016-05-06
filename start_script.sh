#!/bin/bash
/etc/init.d/mongo-db start
sleep 5
/etc/init.d/rlcatalyst start
slepp 5
tail -f /var/log/dmesg

