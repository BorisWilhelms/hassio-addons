#!/usr/bin/with-contenv bashio
CONFIG_PATH=/data/options.json

TENANT_ID="$(bashio::config 'tenantid')"
CLIENT_ID="$(bashio::config 'clientid')"
CLIENT_SECRET="$(bashio::config 'clientsecret')"
RESOURCE_GROUP="$(bashio::config 'resourcegroup')"
ZONE="$(bashio::config 'zone')"
RECORDSET="$(bashio::config 'recordset')"

IP_SERVICE=https://api.ipify.org
SLEEP_TIME=10m
LAST_IP=""

while :
do
    IP=$(curl -s "$IP_SERVICE")
    if [ "$LAST_IP" != "$IP" ]; then
        echo "Updating $RECORDSET.$ZONE to $IP"

        az config set core.output=none > /dev/null 2>&1
        az login --service-principal \
            -u "$CLIENT_ID" \
            -p "$CLIENT_SECRET" \
            --tenant "$TENANT_ID"

        CURRENT_IPS=$(az network dns record-set list \
            -g "$RESOURCE_GROUP" \
            -z "$ZONE" \
            --query "[?name=='$RECORDSET'].aRecords[].ipv4Address" \
            --output tsv)

        ADD=true
        for CURRENT_IP in $CURRENT_IPS
        do
            if [ "$CURRENT_IP" == "$IP" ]; then
                echo "$IP already present. Skipping delete and add."
                ADD=false
                continue
            fi

            echo "Removing $CURRENT_IP"
            az network dns record-set a remove-record \
                -g "$RESOURCE_GROUP" \
                -z "$ZONE" \
                -n "$RECORDSET" \
                -a "$CURRENT_IP"
        done

        if [ "$ADD" == "true" ]; then
            echo "Adding $IP"
            az network dns record-set a add-record \
                -g "$RESOURCE_GROUP" \
                -z "$ZONE" \
                -n "$RECORDSET" \
                -a "$IP"
        fi

        LAST_IP=$IP
    fi

    sleep "$SLEEP_TIME"
done