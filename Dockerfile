FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root/loadrc

COPY ./*.sh /root/loadrc/
COPY ./bashrc/*.sh /root/loadrc/bashrc/
COPY ./gitrc/*.sh /root/loadrc/gitrc/
COPY ./.ssh/id_* /root/.ssh/
COPY ./entrypoint.sh /entrypoint.sh
COPY ./cscope/ /root/loadrc/cscope/
COPY ./neovim/ /root/loadrc/neovim/

# Clean up APT when done.

CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
