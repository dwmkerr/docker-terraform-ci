# A baseline image for general CI tasks with Terraform.
# Provides Terraform binaries, as well as tflint and the AWS CLI.

# At the time of writing, the latest version of Debian is 'strech'. Slim is a
# little leaner, with some rarely used stuff removed.
FROM debian:stretch

# Some metadata.
MAINTAINER Dave Kerr <github.com/dwmkerr>

# Install some common tools we'll need for builds.
# Also install tools needed to use this as a CircleCI 2 build image. See:
#   https://circleci.com/docs/2.0/custom-images/
RUN apt-get update -qq && apt-get install -qq -y \
    make \
    wget \
    git \
    ssh \
    tar \
    gzip \
    unzip \
    ca-certificates \
    python \
    python-pip \
    shellcheck \
    curl

# Install Terraform.
RUN wget -q https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
RUN unzip terraform_0.12.20_linux_amd64.zip
RUN install terraform /usr/local/bin
RUN terraform -v

# Install tflint.
RUN wget -q https://github.com/wata727/tflint/releases/download/v0.13.4/tflint_linux_amd64.zip
RUN unzip tflint_linux_amd64.zip
RUN install tflint /usr/local/bin
RUN chmod ugo+x /usr/local/bin/tflint
RUN tflint -v

# Install the AWS CLI.
RUN pip install awscli==1.16
