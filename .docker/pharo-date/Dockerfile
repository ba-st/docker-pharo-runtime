FROM pharo-runtime:sut

RUN pharo metacello install github://ba-st-dependencies/Teapot:v2 BaselineOfTeapot --groups=Deployment
COPY start.st ./
CMD [ "pharo", "start.st"]
