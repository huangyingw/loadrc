FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
WORKDIR /root/loadrc

COPY ./ /root/loadrc/
COPY ./entrypoint.sh /entrypoint.sh

# Clean up APT when done.

CMD ["/bin/sh", "-c", "/entrypoint.sh 2>&1 | tee /var/logs/containner.log"]
