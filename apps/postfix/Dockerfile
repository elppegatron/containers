# syntax=docker/dockerfile:1

ARG VERSION
FROM quay.io/rockylinux/rockylinux:${VERSION}

# Install only what Postfix strictly needs
RUN microdnf install -y \
        postfix \
        cyrus-sasl-lib \
        ca-certificates \
        openssl \
    && microdnf clean all \
    && rm -rf /var/cache/*

# Ensure postfix user/group exists
RUN getent group postfix || groupadd -r postfix \
    && getent passwd postfix || useradd -r -g postfix -d /var/spool/postfix postfix

# Copy entrypoint script
COPY ./apps/postfix/entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod 500 /usr/sbin/entrypoint.sh \
    && chown root:root /usr/sbin/entrypoint.sh

# Configure postfix to log to stdout
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf

# Postfix listens on SMTP
EXPOSE 25/tcp

# Run Postfix in foreground (required for containers)
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]