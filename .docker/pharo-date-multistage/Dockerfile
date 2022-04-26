FROM pharo-runtime:sut as loader

RUN pharo metacello install github://zeroflag/Teapot:v2.6.0 BaselineOfTeapot --groups=Deployment

FROM pharo-runtime:sut
WORKDIR /app
COPY --from=loader --chown=pharo:users /opt/pharo/Pharo.image ./
COPY --from=loader --chown=pharo:users /opt/pharo/Pharo.changes ./
COPY --from=loader --chown=pharo:users /opt/pharo/Pharo*.sources ./
COPY --chown=pharo:users start.st ./
CMD [ "pharo", "start.st"]
