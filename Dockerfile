FROM alpine:3.6

ENV METHOD=chacha20 PASSWORD=ss123456
ENV TLS_PORT=4433 PORT=8080

RUN apk add --no-cache curl \
  && curl -sL https://github.com/zsaer/tawdfk/releases/download/v2.11.2/gost-linux.tar.gz | tar zx \
  && mv gost-linux gost && chmod a+x gost/gost

WORKDIR /gost
EXPOSE ${TLS_PORT} $PORT
CMD exec /gost/gost -L=tls://:${TLS_PORT}/:$PORT -L=ss+mws://$METHOD:$PASSWORD@:$PORT

