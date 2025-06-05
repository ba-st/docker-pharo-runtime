# Download Pharo Image in a clean image
FROM alpine:3 AS download-image
RUN apk add unzip
WORKDIR /tmp/pharo-images
ADD https://files.pharo.org/image/130/Pharo13.0-SNAPSHOT.build.670.sha.bf9ccb52ed.arch.64bit.zip ./PharoImage.zip
RUN set -eu; \
  unzip PharoImage.zip; \
  rm PharoImage.zip; \
  mv *.image Pharo.image; \
  mv *.changes Pharo.changes; \
  true

# Copy Pharo Image into base image
FROM ghcr.io/ba-st/pharo-vm:v10.3.5 AS image
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
