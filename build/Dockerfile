FROM alpine:latest as buildstage

RUN apk add --no-cache \
        autoconf \
        automake \
        bash \
        bsd-compat-headers \
        build-base \
        cmake \
        ffmpeg4-dev \
        file \
        findutils \
        gettext-dev \
        git \
        gnu-libiconv-dev \
        libdvbcsa-dev \
        libgcrypt-dev \
        libtool \
        libva-dev \
        libvpx-dev \
        libxml2-dev \
        libxslt-dev \
        linux-headers \
        openssl-dev \
        opus-dev \
        patch \
        pcre2-dev \
        pkgconf \
        pngquant \
        python3 \
        sdl2-dev \
        uriparser-dev \
        x264-dev \
        x265-dev \
        zlib-dev && \
    git clone https://github.com/tvheadend/tvheadend.git /tmp/tvheadend && \
    cd /tmp/tvheadend && \
    sed -i 's/=--printf/=-c/' Makefile.webui && \
    ./configure \
        --disable-ffmpeg_static \
        --disable-libfdkaac_static \
        --disable-libtheora_static \
        --disable-libopus_static \
        --disable-libvorbis_static \
        --disable-libvpx_static \
        --disable-libx264_static \
        --disable-libx265_static \
        --disable-libfdkaac \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --disable-avahi \
        --disable-dbus_1 \
        --disable-bintray_cache \
        --disable-execinfo \
        --disable-hdhomerun_static \
        --disable-hdhomerun_client \
        --enable-libav \
        --enable-pngquant \
        --enable-trace \
        --enable-vaapi \
        --infodir=/usr/share/info \
        --localstatedir=/var \
        --mandir=/usr/share/man \
        --prefix=/usr \
        --python=python3 \
        --sysconfdir=/config && \
    make -j 2 && \
    make DESTDIR=/tmp/tvheadend-build install

FROM alpine:latest

RUN apk add --no-cache \
        bsd-compat-headers \
        ffmpeg \
        ffmpeg4-libavcodec \
        ffmpeg4-libavdevice \
        ffmpeg4-libavfilter \
        ffmpeg4-libavformat \
        ffmpeg4-libavutil \
        ffmpeg4-libpostproc \
        ffmpeg4-libswresample \
        ffmpeg4-libswscale \
        gnu-libiconv \
        libdvbcsa \
        libva \
        libva-intel-driver \
        intel-media-driver \
        libvpx \
        libxml2 \
        libxslt \
        linux-headers \
        mesa-va-gallium \
        opus \
        pcre2 \
        perl \
        perl-datetime-format-strptime \
        perl-json \
        perl-json-xs \
        py3-requests \
        python3 \
        uriparser \
        x264 \
        x265 \
        xmltv \
        zlib

COPY --from=buildstage /tmp/tvheadend-build/usr/ /usr/

EXPOSE 9981 9982
VOLUME /config /recordings

ENTRYPOINT ["/usr/bin/tvheadend"]
CMD ["-C", "-c", "/config"]
