#!/bin/bash

if [[ -z "$1" ]]; then
    echo ""
    echo "path not specified"
    echo "command syntax is ./plan.sh <PATH>"
    echo "for instance ./plan/sh mypath/instance"
    echo ""
fi


# Init command used to initialize a working directory containing Terraform configuration files.
# This is the first command that should be run after writing a new Terraform configuration
terraform -chdir=$1 init

# The Get command is used to download and update modules mentioned in the root modules.
terraform -chdir=$1 get

terraform -chdir=$1 validate

# The Plan command is used to create an execution plan
terraform -chdir=$1 plan