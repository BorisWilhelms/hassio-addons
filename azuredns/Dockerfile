ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

# install requirements for azure-cli
RUN apk add --no-cache python3 libffi openssl

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]