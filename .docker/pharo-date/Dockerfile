FROM pharo-runtime:sut

RUN pharo metacello install github://zeroflag/Teapot:v2.6.0 BaselineOfTeapot --groups=Deployment
COPY start.st ./
CMD [ "pharo", "start.st"]
