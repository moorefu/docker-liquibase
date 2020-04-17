FROM openjdk:8-jdk

MAINTAINER MooreFu <chengmu.fu@gmail.com>

# Install MariaDB (MySQL) and PostgreSQL JDBC Drivers for users that would like have them in the container
RUN apt-get update \
  && apt-get install -yq --no-install-recommends \
      libmariadb-java \
      libpostgresql-jdbc-java \
  && curl https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/8.0.19/mysql-connector-java-8.0.19.jar -o /usr/share/java/mysql-connector-java.jar \
  && curl https://repo.maven.apache.org/maven2/com/oracle/database/jdbc/ojdbc6/11.2.0.4/ojdbc6-11.2.0.4.jar -o /usr/share/java/ojdbc6-11.2.0.4.jar \
  && apt-get autoclean \
  && apt-get clean \
  && rm -rf /var/*/apt/*
# /usr/share/java/ojdbc6-11.2.0.4.jar
# /usr/share/java/mysql-connector-java.jar
# /usr/share/java/mariadb-java-client.jar
# /usr/share/java/postgresql.jar


# Add the liquibase user and step in the directory
RUN adduser --system --home /liquibase --disabled-password --group liquibase
WORKDIR /liquibase

# Change to the liquibase user
USER liquibase

# Latest Liquibase Release Version
ARG LIQUIBASE_VERSION=3.8.9

# Download, install, clean up
RUN set -x \
  && curl -L https://github.com/liquibase/liquibase/releases/download/v${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}.tar.gz | tar -xzf -

# Set liquibase to executable
RUN chmod 755 /liquibase

ADD assets /assets

ENTRYPOINT [ "/assets/entrypoint.sh" ]
CMD ["--help"]