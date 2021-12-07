FROM fedora:32

LABEL description="OpenFlow-Language Offline Image https://github.com/istommao/OpenFlow-Language" maintainer="codemax<istommao@gmail.com>"

# ENV LANG en.UTF-8  
# ENV LANGUAGE en:zh  
# ENV LC_ALL en.UTF-8   

ARG TINI_VER=0.19.0

COPY rootfs /

RUN chmod +x /usr/local/bin/* \
 && dnf update -y \
 && dnf install -y git wget dnf-plugins-core openssh-server glibc-locale-source python gettext \
 && pip install --upgrade pip \
 && pip install supervisor \
 && /usr/libexec/openssh/sshd-keygen ed25519 \
 && cd /tmp \
 && wget -q https://github.com/krallin/tini/releases/download/v$TINI_VER/tini_$TINI_VER.rpm \
 && dnf install -y tini_$TINI_VER.rpm \

 && git clone https://github.com/istommao/tibsetup.git /opt/tiosetup \
 && cd /opt/tiosetup \
 && cp /opt/tiodocker/config.docker /opt/tiosetup/private/config \
 && /opt/tiosetup/bootstrap \

 && dnf clean all \
 && rm -rf /tmp/* \
 && rm -f /run/nologin

VOLUME /etc/httpd /srv

EXPOSE 80 81

CMD ["tini","--","startup"]
