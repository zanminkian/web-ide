FROM ubuntu

ENV LANG="C.utf8"

# 1. install common
RUN export DEBIAN_FRONTEND=noninteractive \
    && apt update \
    && apt install -y zsh wget curl git vim unzip tree krb5-user nginx software-properties-common python-is-python3 \
    && chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# 2. install
COPY installers /tmp/installers
RUN ls /tmp/installers | xargs -I {} sh -c /tmp/installers/{} && rm -rf /tmp/installers

# 3. specify the entry
COPY init bootstrap /usr/bin
CMD []
ENTRYPOINT ["bootstrap"]
