FROM fedora:35

LABEL description="OpenFlow-Language Offline Image https://github.com/istommao/OpenFlow-Language" maintainer="codemax<istommao@gmail.com>"

ENV LANG zh_CN.UTF-8  
ENV LANGUAGE zh_CN:zh  
ENV LC_ALL zh_CN.UTF-8   

ARG TINI_VER=0.19.0

COPY rootfs /

RUN chmod +x /usr/local/bin/* \
 && dnf update -y \
 && dnf install -y git wget dnf-plugins-core openssh-server glibc-locale-source python gettext \
 && pip install --upgrade pip \
 && pip install supervisor \
 && /usr/libexec/openssh/sshd-keygen ed25519 \
 && localedef -f UTF-8 -i zh_CN zh_CN.UTF-8 || true \
 # && localedef -v -c -i zh_CN -f UTF-8 zh_CN.UTF-8 || true \
 && cd /tmp \
 && wget -q https://github.com/krallin/tini/releases/download/v$TINI_VER/tini_$TINI_VER.rpm \
 && dnf install -y tini_$TINI_VER.rpm \

 && git clone https://github.com/TryItOnline/tiosetup.git /opt/tiosetup \
 && cd /opt/tiosetup \
 && cp /opt/tiodocker/config.docker /opt/tiosetup/private/config \
 && /opt/tiosetup/bootstrap \

 && dnf clean all \
 && rm -rf /tmp/* \
 && rm -f /run/nologin

VOLUME /etc/httpd /srv

EXPOSE 80 81

CMD ["tini","--","startup"]
