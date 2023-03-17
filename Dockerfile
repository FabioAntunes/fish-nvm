FROM ubuntu:18.10
RUN apt-get update && \
  apt-get install -y software-properties-common && \
  apt-add-repository -y ppa:fish-shell/release-3  && \
  apt-get update && \
  apt-get install -y fish && \
  apt-get install -y git && \
  apt-get install -y curl && \
  apt-get install -y python2.7 python-pip && \
  apt-get install -y locales && \
  locale-gen "en_US.UTF-8"

RUN git clone https://github.com/creationix/nvm.git ~/.nvm

CMD /usr/bin/fish
