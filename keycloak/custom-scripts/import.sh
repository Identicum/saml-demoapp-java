#!/bin/bash

export PATH=$PATH:$JBOSS_HOME/bin

for i in {1..10}; do
    kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user $KEYCLOAK_USER --password $KEYCLOAK_PASSWORD
    custom_realm=$(kcadm.sh get realms/demorealm)
    if [ -z "$custom_realm" ]; then
        echo "Importing custom realm."
        kcadm.sh create realms -f /opt/jboss/keycloak/objects/realm.json
        echo "Importing clients."
        for f in /opt/jboss/keycloak/objects/clients/*.json; do
            kcadm.sh create clients -r demorealm -f $f
        done
        echo "Importing users."
        for f in /opt/jboss/keycloak/objects/users/*.json; do
            kcadm.sh create users -r demorealm -f $f
        done
    else
        echo "the custom realm already exists."
        exit
    fi
    sleep 5s
done