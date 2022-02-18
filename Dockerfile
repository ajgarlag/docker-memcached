FROM ajgarlag/debian:bullseye

RUN apt-get update \
    && apt-get install -y \
        memcached \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/^-l /#-l /g' \
        -e 's/^logfile .*/logfile \/dev\/stdout/g' \
        -i /etc/memcached.conf

RUN mkdir -p /var/run/memcached && chown -R memcache:memcache /var/run/memcached

EXPOSE 11211
CMD ["/usr/share/memcached/scripts/systemd-memcached-wrapper"]
