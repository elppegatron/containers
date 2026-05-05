# Rocky Linux 10 minimal base
FROM quay.io/rockylinux/rockylinux:10-minimal

# Install only what Postfix strictly needs
RUN microdnf install -y \
        postfix \
        cyrus-sasl-lib \
        ca-certificates \
        openssl \
    && microdnf clean all \
    && rm -rf /var/cache/*

# Ensure postfix user/group exists (usually created by package, but be explicit)
RUN getent group postfix || groupadd -r postfix \
    && getent passwd postfix || useradd -r -g postfix -d /var/spool/postfix postfix

# Copy a minimal entrypoint
COPY .apps/postfix/scripts/entrypoint.sh /entrypoint.sh
RUN chmod 500 /entrypoint.sh \
    && chown postfix:postfix /entrypoint.sh

# Configure postfix to log to stdout
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf

# Postfix listens on SMTP
EXPOSE 25/tcp

# Run Postfix in foreground (required for containers)
ENTRYPOINT ["/entrypoint.sh"]