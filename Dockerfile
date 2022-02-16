FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root/loadrc

COPY ./*.sh /root/loadrc/
COPY ./neovim/ /root/loadrc/neovim/
COPY ./cscope/ /root/loadrc/cscope/
COPY ./.ssh/id_* /root/.ssh/
COPY ./entrypoint.sh /entrypoint.sh

RUN /root/loadrc/fix_resolvconf_in_docker.sh 
RUN /root/loadrc/install_prerequisite.sh
RUN chmod 400 /root/.ssh/id_rsa
RUN /root/loadrc/install_nvim.sh
RUN /root/loadrc/cscope/install-sh.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
