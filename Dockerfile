FROM jboss/wildfly

# Environment variable with default value
#ARG APP_FILE=appfile.war

#RUN echo ${APP_FILE}

# Add your application to the deployment folder
#ADD ${APP_FILE} /opt/jboss/wildfly/standalone/deployments/${APP_FILE}

# Add standalone-ha.xml - set your own network settings
#ADD standalone-ha-1.xml /opt/jboss/wildfly/standalone/configuration/standalone-ha-1.xml

# Add user for adminstration purpose
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin123 --silent


# Add user for slave access purpose in Domain Controler configuration
# To represent the user add the following to the server-identities definition <secret value="c2xhdmUxMjM=" />
RUN /opt/jboss/wildfly/bin/add-user.sh -u slave -p slave123 -g 'ManagementRealm' --display-secret
