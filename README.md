# docker-terraform-ci [![CircleCI](https://circleci.com/gh/dwmkerr/docker-terraform-ci.svg?style=shield)](https://circleci.com/gh/dwmkerr/docker-terraform-ci) [![Greenkeeper badge](https://badges.greenkeeper.io/dwmkerr/docker-terraform-ci.svg)](https://greenkeeper.io/) [![GuardRails badge](https://badges.guardrails.io/dwmkerr/docker-dynamodb.svg?token=569f2cc38a148f785f3a38ef0bcf5f5964995d7ca625abfad9956b14bd06ad96&provider=github)](https://dashboard.guardrails.io/default/gh/dwmkerr/docker-dynamodb)

[![Docker Hub Badge](http://dockeri.co/image/dwmkerr/terraform-ci)](https://registry.hub.docker.com/u/dwmkerr/terraform-ci/)

The `dwmkerr/terraform-ci` Dockerfile provides a useful baseline image for run Terraform related CI tasks.

<!-- vim-markdown-toc GFM -->

* [Introduction](#introduction)
* [Tooling](#tooling)
* [Coding](#coding)
    * [The Makefile](#the-makefile)
    * [The Tests](#the-tests)
    * [Creating a Release](#creating-a-release)

<!-- vim-markdown-toc -->

# Introduction

You can use this image to run CI pipelines which build infrastructure. There is a more detailed article describing this approach on the way, which uses a CI build for [`dwmkerr/terraform-aws-openshift`](https://github.com/dwmkerr/terraform-aws-openshift) as an example.

The image is based on Debian Stretch (specifically the official [`debian:stretch`](https://hub.docker.com/_/debian/) image).

# Tooling

This image contains a number of tools which are useful when working with Terraform.

All baseline Debian stretch tools, as well as tools needed by CircleCI 2 images, and some useful utilities:

- `make`
- `wget`
- `git`
- `ssh`
- `tar`
- `gzip`
- `unzip`
- `ca-certificates`
- `curl`
- [`shellcheck`](https://github.com/koalaman/shellcheck)

Terraform, [Terraform Lint](https://github.com/wata727/tflint) and [Checkov](https://github.com/bridgecrewio/checkov):

- `terraform` (0.13)
- `tflint` (0.18)
- `checkov` (latest)

Cloud CLIs which are for [Terraform Backends](https://www.terraform.io/docs/backends/)

- `aws` (1.16)
- `az` (latest)

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

## Creating a Release

To create a release:

- Merge your work to master
- Use `npm run release` to bump and update the changelog
- Push and deploy `git push --follow-tags`

A `package.json` file is used to store the version number, however the project has no other dependencies on Node.js than this part of the release process. It is just allows for convenient management of a `CHANGELOG.md` file and the version by using [standard-version](https://github.com/conventional-changelog/standard-version).
