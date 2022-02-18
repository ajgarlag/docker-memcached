FROM ajgarlag/debian:buster

RUN groupadd --system --gid 11211 memcache && useradd --system --gid memcache --uid 11211 memcache

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        memcached \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/^-l /#-l /g' \
        -e 's/^logfile .*/logfile \/dev\/stdout/g' \
        -i /etc/memcached.conf

RUN mkdir -p /var/run/memcached && chown -R memcache:memcache /var/run/memcached

EXPOSE 11211
CMD ["/usr/share/memcached/scripts/systemd-memcached-wrapper"]
