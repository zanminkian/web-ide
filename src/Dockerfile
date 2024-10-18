FROM ubuntu

ENV LANG="C.utf8"

# 1. install common
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt update \
  && apt install -y zsh curl git vim unzip \
  && chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# 2. install
COPY installers /tmp/installers
COPY install.sh /tmp/install.sh
RUN /tmp/install.sh
RUN rm -rf /tmp/installers /tmp/install.sh

# 3. entry & init
COPY scripts /usr/bin

CMD []
ENTRYPOINT ["bootstrap"]
