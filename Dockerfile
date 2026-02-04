FROM ubuntu:22.04

ARG GOPHISH_VERSION=0.12.1

RUN apt-get update && apt-get install -y wget unzip ca-certificates jq && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/gophish

RUN wget -O gophish.zip https://github.com/gophish/gophish/releases/download/v${GOPHISH_VERSION}/gophish-v${GOPHISH_VERSION}-linux-64bit.zip \
    && unzip gophish.zip \
    && rm gophish.zip \
    && chmod +x gophish

COPY config.json /opt/gophish/config.json
COPY entrypoint.sh /opt/gophish/entrypoint.sh

RUN chmod +x /opt/gophish/entrypoint.sh

# Railway 會用 $PORT 對外暴露（通常是 8080/3000/等）
EXPOSE 8080

ENTRYPOINT ["/opt/gophish/entrypoint.sh"]
