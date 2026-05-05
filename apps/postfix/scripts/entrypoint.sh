#!/bin/sh
set -e

# Sanity check configuration before starting
postfix check

# Run Postfix in the foreground for Kubernetes
exec postfix start-fg