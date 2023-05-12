# How to use as dependency

In your `Dockerfile` put something like:

```dockerfile
FROM ghcr.io/ba-st/pharo:v11.0.0
```

If you want to create a custom Pharo image it's better to use multi-stage builds
using `pharo-loader` as the base to load the code. This image disables Epicea and
configure Iceberg to use HTTPS.

For example

```dockerfile
FROM ghcr.io/ba-st/pharo-loader:v11.0.0 AS loader
RUN pharo metacello install github://owner/repo:branch BaselineOfProject

FROM ghcr.io/ba-st/pharo:v11.0.0
COPY --from=loader /opt/pharo/Pharo.image ./
COPY --from=loader /opt/pharo/Pharo.changes ./
COPY --from=loader /opt/pharo/Pharo*.sources ./

...
```
