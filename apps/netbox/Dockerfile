# syntax=docker/dockerfile:1

ARG VERSION
FROM ghcr.io/netbox-community/netbox:${VERSION}

USER root

# Install netbox plugins
RUN /usr/local/bin/uv pip install netboxlabs-diode-netbox-plugin

USER netbox