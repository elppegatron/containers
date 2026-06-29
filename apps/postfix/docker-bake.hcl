target "docker-metadata-action" {}

variable "APP" {
  default = "postfix"
}

variable "VERSION" {
  // renovate: datasource=docker depName=quay.io/rockylinux/rockylinux
  default = "10-minimal@sha256:b2b9c31b2825870b8b825ea5b93b2bbc0440871d4b185c39721f09a6b8c9d7c2"
}

variable "SOURCE" {
  default = "https://www.postfix.org"
}

group "default" {
  targets = ["image-local"]
}

target "image" {
  inherits = ["docker-metadata-action"]
  args = {
    VERSION = "${VERSION}"
  }
  labels = {
    "org.opencontainers.image.source" = "${SOURCE}"
  }
}

target "image-local" {
  inherits = ["image"]
  output = ["type=docker"]
  tags = ["${APP}:${VERSION}"]
}

target "image-all" {
  inherits = ["image"]
  platforms = [
    "linux/amd64"
  ]
}