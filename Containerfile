FROM registry.access.redhat.com/ubi8/php-80
USER 0
# Install & configure redis extension (pecl)
RUN yum install --setopt=tsflags=nodocs php-pear php-devel -y && \
    pecl channel-update pecl.php.net && \
    pecl install  -D "enable-redis-igbinary='yes' enable-redis-lzf='no' enable-redis-zstd='no'" igbinary igbinary-devel redis && \
    echo -e ";extension redis\nextension=igbinary\nextension=redis\n" > /etc/php.d/20-redis.ini
# Reset permissions of filesystem to default values
RUN /usr/libexec/container-setup && rpm-file-permissions
USER 1001
