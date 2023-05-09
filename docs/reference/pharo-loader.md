# Pharo Loader Image

The `pharo-loader` docker image is intended for loading code and producing a
Pharo image to combine with the base runtime image in a multistage build.

Since the intention for these containers is to be ephemeral the Dockerfile
instructions disable Epicea, changes recording and Monticello's cache repository.
