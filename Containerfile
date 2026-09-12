FROM quay.io/fedora/fedora-bootc:44@sha256:2c38c5f71a43993e07577629ef8e1695420ed38143482340215abdcea85a31fd

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
