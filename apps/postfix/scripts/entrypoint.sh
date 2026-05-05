#!/bin/sh
set -e

# Prepare required directories within PVC
mkdir -p /var/spool/postfix 
chown -R postfix:postfix /var/spool/postfix

# Sanity check configuration before starting
postfix check

# Run Postfix in the foreground for Kubernetes
exec postfix start-fg