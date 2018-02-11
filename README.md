# docker-terraform-ci [![CircleCI](https://circleci.com/gh/dwmkerr/docker-terraform-ci.svg?style=shield)](https://circleci.com/gh/dwmkerr/docker-terraform-ci)

[![Docker Hub Badge](http://dockeri.co/image/dwmkerr/terraform-ci)](https://registry.hub.docker.com/u/dwmkerr/terraform-ci/)

The `dwmkerr/terraform-ci` Dockerfile provides a useful baseline image for run Terraform related CI tasks.

You can use this image to run CI pipelines which build infrastructure.

The image is based on Debian Stretch (specifically the official [`debian:stretch`](https://hub.docker.com/_/debian/) image).

It contains:

- All baseline Debian stretch tools
- `make`
- `wget`
- `git`
- `ssh`
- `tar`
- `gzip`
- `unzip`
- `ca-certificates`
- `terraform`
- `tflint`

# Coding

The code is structued like this:

```
Dockerfile     # the important thing, the actual dockerfile
makefile       # commands to build, test deploy etc
test.sh        # a simple test script
package.json   # used for versioning only
```

## The Makefile

The makefile contains commands to build, test and deploy. Parameters can be passed as environment variables or through the commandline.

| Command                  | Notes                             |
|--------------------------|-----------------------------------|
| `make build`             | Builds the image `dwmkerr/terraform-ci:latest` and `dwmkerr/terraform-ci:<version>`. The version is loaded from [`package.json`](./package.json). |
| `make test`              | Runs the test scripts. |
| `make deploy`            | Deploys the images to the docker hub. If you are not logged in, you're gonna have a bad time. |

## The Tests

The tests are simple bash scripts which check for basic capabilties *which relate to the image*. Essentially, this means they'll test the tools are installed.
