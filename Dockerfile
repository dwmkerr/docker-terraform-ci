# A baseline image for general CI tasks with Terraform.
# Provides Terraform binaries, as well as tflint and the AWS CLI.

# At the time of writing, the latest version of Debian is 'strech'. Slim is a
# little leaner, with some rarely used stuff removed.
FROM debian:buster

# Some metadata.
MAINTAINER Dave Kerr <github.com/dwmkerr>

# Build arguments, which are used to control version numbers.
ARG VERSION_TERRAFORM=0.13.0
ARG VERSION_TFLINT=0.18.0
ARG VERSION_AWS_CLI=1.16
ARG VERSION_CHECKOV=1.0.484

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
    python3-dev \
    python3-pip \
    shellcheck \
    curl

# Install Terraform.
RUN wget -q https://releases.hashicorp.com/terraform/${VERSION_TERRAFORM}/terraform_${VERSION_TERRAFORM}_linux_amd64.zip
RUN unzip terraform_${VERSION_TERRAFORM}_linux_amd64.zip
RUN install terraform /usr/local/bin
RUN terraform -v

# Install tflint.
RUN wget -q https://github.com/wata727/tflint/releases/download/v${VERSION_TFLINT}/tflint_linux_amd64.zip
RUN unzip tflint_linux_amd64.zip
RUN install tflint /usr/local/bin
RUN chmod ugo+x /usr/local/bin/tflint
RUN tflint -v

# Install Checkov.
RUN pip3 install --upgrade setuptools
RUN pip3 install checkov==${VERSION_CHECKOV}
RUN checkov -v

# Install the AWS CLI.
RUN pip3 install awscli==${VERSION_AWS_CLI}

# Install the Azure CLI.
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
