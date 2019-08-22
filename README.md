# docker-terraform-ci [![CircleCI](https://circleci.com/gh/dwmkerr/docker-terraform-ci.svg?style=shield)](https://circleci.com/gh/dwmkerr/docker-terraform-ci) [![Greenkeeper badge](https://badges.greenkeeper.io/dwmkerr/docker-terraform-ci.svg)](https://greenkeeper.io/) [![GuardRails badge](https://badges.production.guardrails.io/dwmkerr/docker-terraform-ci.svg)](https://www.guardrails.io)

[![Docker Hub Badge](http://dockeri.co/image/dwmkerr/terraform-ci)](https://registry.hub.docker.com/u/dwmkerr/terraform-ci/)

The `dwmkerr/terraform-ci` Dockerfile provides a useful baseline image for run Terraform related CI tasks.

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
* [Tooling](#tooling)
* [Coding](#coding)
    * [The Makefile](#the-makefile)
    * [The Tests](#the-tests)

<!-- vim-markdown-toc -->

# Introduction

You can use this image to run CI pipelines which build infrastructure. There is a more detailed article describing this approach on the way, which uses a CI build for [`dwmkerr/terraform-aws-openshift`](https://github.com/dwmkerr/terraform-aws-openshift) as an example.

The image is based on Debian Stretch (specifically the official [`debian:stretch`](https://hub.docker.com/_/debian/) image).

# Tooling

This image contains a number of tools which are useful when working with Terraform.

All baseline Debian stretch tools:

- `make`
- `wget`
- `git`
- `ssh`
- `tar`
- `gzip`
- `unzip`
- `ca-certificates`

Terraform, and [Terraform Lint](https://github.com/wata727/tflint):

- `terraform` (0.12)
- `tflint` (0.10)

Some tools which are useful for [Terraform Backends](https://www.terraform.io/docs/backends/)

- `aws`

# Coding 

The code is structured like this:

```
Dockerfile     # the important thing, the actual dockerfile
makefile       # commands to build, test deploy etc
test.sh        # a simple test script
package.json   # used for versioning only
```

## The Makefile

The makefile contains commands to build, test and deploy. Parameters can be passed as environment variables or through the command-line.

| Command                  | Notes                             |
|--------------------------|-----------------------------------|
| `make build`             | Builds the image `dwmkerr/terraform-ci:latest` and `dwmkerr/terraform-ci:<version>`. The version is loaded from [`package.json`](./package.json). |
| `make test`              | Runs the test scripts. |
| `make deploy`            | Deploys the images to the docker hub. If you are not logged in, you're gonna have a bad time. |

## The Tests

The tests are simple bash scripts which check for basic capabilities *which relate to the image*. Essentially, this means they'll test the tools are installed.
