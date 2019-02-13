FROM ubuntu:18.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y \
        build-essential \
        coreutils \
        cscope \
        curl \
        gdebi-core \
        git \
        inetutils-traceroute \
        iputils-ping \
        manpages-pl \
        netcat \
        perl \
        pwgen \
        python3-software-properties \
        rsync \
        software-properties-common \
        ssh \
        vim-gnome \
        wget

WORKDIR /root/loadrc

COPY ./.ssh/id_* /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa

COPY ./install_nvim_pre.sh /root/loadrc/install_nvim_pre.sh
RUN /root/loadrc/install_nvim_pre.sh

COPY ./install_cscope.sh /root/loadrc/install_cscope.sh
RUN /root/loadrc/install_cscope.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
