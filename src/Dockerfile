FROM ubuntu

ENV LANG="C.utf8"

# 1. install common
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt update \
  && apt install -y zsh wget curl git vim unzip tree krb5-user \
  && chsh -s /usr/bin/zsh
SHELL ["/usr/bin/zsh", "-c"]

# 2. install
COPY installers /tmp/installers
RUN ls /tmp/installers | xargs -I {} sh -c /tmp/installers/{}
RUN rm -rf /tmp/installers

# 3. init
COPY web-ide-init /usr/bin/
RUN echo '# web-ide\n\
if [ -f "/usr/bin/web-ide-init" ]\n\
then\n\
  /usr/bin/web-ide-init\n\
  rm -rf /usr/bin/web-ide-init\n\
fi\n\
' >> $HOME/.zshrc

# 4. entry
COPY bootstrap /usr/bin/
CMD []
ENTRYPOINT ["bootstrap"]
