FROM nucleardreamer/air-docker

RUN useradd -ms /bin/bash user && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    mkdir -p /etc/opt/Adobe\ AIR/ && mkdir /tso && \
    apt-get update && apt-get install -y -q dpkg && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD tsoclient /tso

RUN dpkg -i /tso/python3-six_1.16.0-2_all.deb && \
    dpkg -i /tso/python3-dateutil_2.8.1-6_all.deb && \
    cp /tso/globalRuntime.conf /etc/opt/Adobe\ AIR/ && \
    chown -R user:user /tso/share

USER user
RUN mkdir -p /home/user/.appdata/Adobe/AIR && \
    echo 1 > /home/user/.appdata/Adobe/AIR/UpdateDisabled && \
    echo 2 > /home/user/.appdata/Adobe/AIR/eulaAccepted

ENTRYPOINT ["/tso/entrypoint"]
