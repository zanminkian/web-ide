FROM debian

ARG VERSION
ENV VERSION=${VERSION}
ENV LANG="C.utf8"

# 1. install common
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt update \
  && apt install -y zsh curl git vim sudo \
  && chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# 2. install
COPY install /tmp/install
COPY install.sh /tmp/install.sh
RUN /tmp/install.sh
RUN rm -rf /tmp/install /tmp/install.sh

# 3. setup
RUN useradd -m -s /usr/bin/zsh -G sudo web-ide
USER web-ide
COPY --chown=web-ide setup /tmp/setup
COPY --chown=web-ide setup.sh /tmp/setup.sh
RUN /tmp/setup.sh
RUN rm -rf /tmp/setup /tmp/setup.sh
USER root

# 4. entry & init
COPY scripts /usr/bin

CMD []
ENTRYPOINT ["bootstrap"]
