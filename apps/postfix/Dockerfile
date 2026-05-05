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

# Prepare required directories
RUN mkdir -p \
        /var/spool/postfix \
        /etc/postfix/tls \
        /var/lib/postfix \
    && chown -R postfix:postfix \
        /var/spool/postfix \
        /var/lib/postfix \
    && chown root:postfix /etc/postfix/tls \
    && chmod 750 /etc/postfix/tls

# Copy a minimal entrypoint
COPY ./apps/postfix/scripts/entrypoint.sh /usr/sbin/entrypoint.sh
RUN chmod 500 /usr/sbin/entrypoint.sh \
    && chown root:root /usr/sbin/entrypoint.sh

# Configure postfix to log to stdout
RUN echo "maillog_file = /dev/stdout" >> /etc/postfix/main.cf

# Postfix listens on SMTP
EXPOSE 25/tcp

# Run Postfix in foreground (required for containers)
ENTRYPOINT ["/usr/sbin/entrypoint.sh"]