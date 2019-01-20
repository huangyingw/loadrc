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
        netcat \
        perl \
        pwgen \
        python3-software-properties \
        rsync \
        software-properties-common \
        ssh \
        vim-gnome \
        wget

COPY ./.ssh/ /root/.ssh/
RUN chmod 400 /root/.ssh/id_rsa
COPY ./install_nvim_pre.sh /root/loadrc/install_nvim_pre.sh
WORKDIR /root/loadrc
RUN /root/loadrc/install_nvim_pre.sh
COPY ./cscope/ /root/loadrc/cscope/
RUN /root/loadrc/cscope/build_pre.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
