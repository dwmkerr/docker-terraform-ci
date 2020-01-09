#!/usr/bin/env bash

# Bomb if anything fails.
set -e

IMAGE_NAME="dwmkerr/terraform-ci" # For CI
# IMAGE_NAME="docker-terraform-ci" # For local testing

function assert_installed {
    program=$1
    command=$2

    echo "Checking ${program} is installed..."
    result=$(eval "docker run ${IMAGE_NAME} command -v ${command}")
    if ! [ -x "${result}" ]; then
        echo "Error: Expected ${program} to be installed" >&2
        exit 1
    else
        echo "Success: ${program} is installed"
    fi
}
function assert_version {
    program=$1
    command=$2
    version=$3

    echo "Checking ${program} version..."
    result=$(eval "docker run ${IMAGE_NAME} ${command}" 2>&1)
    if [[ ${result} != *"${version}"* ]]; then
        echo "Error: Expected ${program} ${version}, but got: ${result}" >&2
        exit 1
    else
        echo "Success: Found ${program} ${version}"
    fi
}

# Assert the versions of tools we need.
assert_version "terraform" "terraform -v" "0.12.19"
assert_version "tflint" "tflint -v" "0.13.4"
assert_version "awscli" "aws --version" "1.16"
