#!/bin/bash

echo TERRAVARS STARTED...

resources="family
requires_compabilities
task_role_arn
execution_role_arn
network_mode
cpu
memory
container_definitions
tags"

descriptions="Cluster name
The launch way e.g: FARGATE.
Task-role ARN.
Execution-role ARN.
Network mode e.g: awsvpc.
CPU quantity.
Memory quantity.
Container attibutions.
Resource tags."

types="string
string
string
string
string
number
number
map(string)
list(string)"

SAVEIFS=$IFS
IFS=$'\n'
resources=($resources)
descriptions=($descriptions)
types=($types)
IFS=$SAVEIFS

for i in ${!resources[@]}; do
  echo creating \"${resources[$i]}\" variable.

  bodyMsg="variable \"${resources[$i]}\" {
description = \"${descriptions[$i]}\"
type = ${types[$i]}
}
"
  echo "$bodyMsg" >> vars.tf
done

echo "FORMATTING vars.tf TO BE IN THE PATTERN."
: $(terraform fmt vars.tf)

echo "TERRAVARS CREATES: vars.tf (terraform variables files)."
echo TERRAVARS FINISHED.
