#!/bin/bash

current_version=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

incremented_version=$(echo $current_version | awk -F. '{print $1 "." $2 "." ++$3}')

mvn versions:set -DnewVersion=${incremented_version}


echo "Version incremented from ${current_version} to ${incremented_version}"
