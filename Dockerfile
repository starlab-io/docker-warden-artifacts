FROM centos:6
MAINTAINER Star Lab <info@starlab.io>

RUN mkdir /source

# The ADD command will also extract .tar.gz files
ADD json-c-0.11-nodoc.tar.gz /tmp/

# For some reason, this isn't actually available through yum, despite being
# in the mirrors (as far as I can tell)
ADD zlib-static-1.2.3-29.el6.i686.rpm /tmp/zlib-static-1.2.3-29.el6.i686.rpm

RUN yum install -y glibc-devel glibc-static libz-devel zlib-static glibc-devel.i686 \
    glibc-static.i686 libstdc++-devel.i686 zlib.i686 zlib-devel.i686 && \
    yum groupinstall -y "Development Tools" && \
    yum clean all

RUN yum install -y /tmp/*.rpm

RUN cd /tmp/json-c-0.11 && ./configure && make CFLAGS='-m32' && make install
RUN rm -rf /var/cache/yum/* /tmp/* /var/tmp/*