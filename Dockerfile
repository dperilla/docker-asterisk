# Version: 0.0.1 - Certified Asterisk 13.1-cert2 with sip and pjsip
FROM debian:latest
MAINTAINER David Muñoz "david@3vases.com"
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential openssl libjansson-dev sqlite \
                       libxml2-dev libncurses5-dev uuid-dev sqlite3 libsqlite3-dev pkg-config \
                       wget vim subversion git aptitude libreadline-dev libreadline6-dev \
                       libiksemel-dev libvorbis-dev libssl-dev libspeex-dev libspeexdsp-dev \ 
                       mpg123 libmpg123-0 sox libsrtp0-dev \
                   && apt-get autoclean \
                   && apt-get autoremove \
                   && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src
RUN git clone https://github.com/asterisk/pjproject pjproject
WORKDIR pjproject
RUN ./configure --prefix=/usr --enable-shared --disable-sound --disable-resample --disable-video --disable-opencore-amr CFLAGS='-O2 -DNDEBUG'
RUN make dep &&  make && make install && ldconfig
WORKDIR /usr/src
RUN wget http://downloads.asterisk.org/pub/telephony/certified-asterisk/asterisk-certified-13.8-current.tar.gz \
&& tar -zxvf asterisk-certified-13.8-current.tar.gz
WORKDIR /usr/src/asterisk-certified-13.8-cert1
RUN sh ./contrib/scripts/get_mp3_source.sh
RUN ./configure CFLAGS='-g -O2 -mtune=native' --libdir=/usr/lib
COPY menuselect.makeopts /usr/src/asterisk-certified-13.8-cert1/menuselect.makeopts
RUN sed -i '/NATIVE_ARCH=/c \NATIVE_ARCH=0' /usr/src/asterisk-certified-13.8-cert1/build_tools/menuselect-deps
RUN make clean && make && make install && make samples
WORKDIR /root
RUN sed -i "s/rtpstart=10000/rtpstart=16384/g" /etc/asterisk/rtp.conf
RUN sed -i "s/rtpend=20000/rtpend=16394/g" /etc/asterisk/rtp.conf

#Expose volumes
VOLUME /var/log/asterisk
VOLUME /etc/asterisk
VOLUME /var/lib/asterisk

CMD ["/usr/sbin/asterisk", "-vvvvvvv"]
