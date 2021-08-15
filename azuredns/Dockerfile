ARG BUILD_FROM=homeassistant/amd64-base:latest
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache --virtual .build-dependencies \
        build-base \
        libffi-dev \
        openssl-dev \
        python3-dev \
        && apk add --no-cache py3-pip py3-wheel

# install requirements for azure-cli
RUN pip3 install --no-cache-dir \
    azure-cli

RUN apk del --no-cache --purge .build-dependencies

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]