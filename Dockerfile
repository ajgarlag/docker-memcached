FROM ajgarlag/debian:jessie

RUN apt-get update \
    && apt-get install -y \
        memcached \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/^-l /#-l /g' \
        -e 's/^logfile .*/logfile \/dev\/stdout/g' \
        -i /etc/memcached.conf

EXPOSE 11211
CMD ["/usr/share/memcached/scripts/systemd-memcached-wrapper"]
STOPSIGNAL SIGINT
