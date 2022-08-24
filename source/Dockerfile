# Download Pharo Image in a clean image
FROM alpine:3 as download-image
RUN apk add unzip
WORKDIR /tmp/pharo-images
ADD https://files.pharo.org/image/100/Pharo10.0.1-0.build.527.sha.0542643.arch.64bit.zip ./PharoImage.zip
RUN set -eu; \
  unzip PharoImage.zip; \
  rm PharoImage.zip; \
  mv *.image Pharo.image; \
  mv *.changes Pharo.changes; \
  true

# Copy Pharo Image into base image
FROM ghcr.io/ba-st/pharo-vm:v9.0.17 as image
LABEL org.opencontainers.image.authors="Buenos Aires Smalltalk <github@fast.org.ar>"
WORKDIR /opt/pharo
USER root
RUN set -eu; \
  printf '#!/usr/bin/env bash\nexec pharo-vm Pharo.image "$@"' > /opt/pharo/pharo; \
  ln -s /opt/pharo/pharo /usr/local/bin/pharo; \
  chmod a+x /usr/local/bin/pharo; \
  chown 7431:100 /opt/pharo -R; \
  true
COPY --from=download-image --chown=pharo:users /tmp/pharo-images /opt/pharo/
RUN chmod a+w /opt/pharo
USER pharo
