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
RUN ls /tmp/installers | grep .installer.sh | xargs -I {} sh -c /tmp/installers/{}
RUN rm -rf /tmp/installers

# 3. entry & init
COPY bootstrap web-ide-init /usr/bin/

CMD []
ENTRYPOINT ["bootstrap"]
