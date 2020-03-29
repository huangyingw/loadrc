FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root/loadrc

COPY ./*.sh /root/loadrc/
COPY ./.ssh/id_* /root/.ssh/
COPY ./entrypoint.sh /entrypoint.sh

RUN /root/loadrc/install_prerequisite.sh
RUN chmod 400 /root/.ssh/id_rsa
RUN /root/loadrc/install_nvim_pre.sh
RUN /root/loadrc/install_cscope.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
