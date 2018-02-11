#!/usr/bin/env bash

# Bomb if anything fails.
set -e

function check_version {
    program=$1
    command=$2
    version=$3

    echo "Checking ${program} version..."
    result=$(eval "docker run dwmkerr/terraform-ci ${command}")
    if [[ ${result} != *"${version}"* ]]; then
        echo "Error: Expected ${program} ${version}, but got: ${result}" >&2
        exit 1
    else
        echo "Success: Found ${program} ${version}"
    fi
}

# Check the terraform version.
terraform=$(docker run dwmkerr/terraform-ci terraform -v)
check_version "terraform" "terraform -v" "0.11.3"
check_version "tflint" "tflint -v" "0.5.4"
