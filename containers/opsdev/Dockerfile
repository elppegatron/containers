FROM ghcr.io/tkpegatron/alpine:rolling@sha256:004aa4600c48be1d098fa3fe0ae414cd10598162795730d745d3096a97790e3f

# -{ MOD: Add repositories }
RUN /bin/true \
    && echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories \
    && echo "https://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories

# -{ MOD: Add ops packages}
RUN apk add --upgrade --no-cache \
      # Fundamentals
      coreutils binutils findutils grep \
      # Shell environment
      zsh bat exa git direnv stow file \
      skim neovim gpg gpg-agent openssh-client \
      sshpass rsync envsubst starship tzdata \
      age sops jq yq ipcalc yamllint openssl \
      # Development libraries
      python3 py3-pip libcrypto3 pcre \
      # Development Tools
      kubectl kustomize helm flux \
      # Troubleshooting tools
      dog

# -{ MOD: Install go-task manually }
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
