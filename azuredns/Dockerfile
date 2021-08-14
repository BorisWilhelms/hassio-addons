ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

RUN apk add --no-cache --virtual .build-dependencies \
        build-base \
        libffi-dev \
        openssl-dev \
        py3-wheel \
        python3-dev \
        py3-pip \
        python3

# install requirements for azure-cli
RUN pip3 install azure-cli

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]