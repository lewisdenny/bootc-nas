FROM quay.io/fedora/fedora-bootc:44@sha256:1c529af15cb9805ab11fb2c1f5826699f9e8871a64d4a0e793bb0a57445ceaa7

# NAS packages
COPY packages.txt /tmp/packages.txt
COPY scripts/install-packages.sh /tmp/install-packages.sh
RUN /tmp/install-packages.sh /tmp/packages.txt

# Enable base services that should always be on
RUN systemctl enable \
      cockpit.socket \
      avahi-daemon.service \
      smartd.service \
      firewalld.service \
      node_exporter.service

# Shell niceties
RUN echo 'alias vi=nvim' >> /etc/profile.d/nvim.sh && \
    echo 'alias vim=nvim' >> /etc/profile.d/nvim.sh

# Ship default configs
# COPY etc/ /etc/
