FROM ajgarlag/debian:stretch

RUN groupadd --system --gid 11211 memcache && useradd --system --gid memcache --uid 11211 memcache

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        memcached \
    && rm -rf /var/lib/apt/lists/*

RUN sed -e 's/^-l /#-l /g' \
        -e 's/^logfile .*/logfile \/dev\/stdout/g' \
        -i /etc/memcached.conf

EXPOSE 11211
CMD ["/usr/share/memcached/scripts/systemd-memcached-wrapper"]
