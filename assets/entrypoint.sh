#!/bin/sh
LIQUIBASE_OPTS=""
if [ -n "${DB_CHANGE_LOG_FILE}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --changeLogFile=${DB_CHANGE_LOG_FILE}"
fi
if [ -n "${DB_DRIVER}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --driver=${DB_DRIVER}"
fi
if [ -z "${DB_DRIVER_CLASSPATH}" ]; then
    case $DB_DRIVER in
    oracle.jdbc.OracleDriver)
        DB_DRIVER_CLASSPATH="/usr/share/java/ojdbc6-11.2.0.4.jar"
    ;;
    com.mysql.cj.jdbc.Driver)
        DB_DRIVER_CLASSPATH="/usr/share/java/mysql-connector-java.jar"
    ;;
    org.postgresql.Driver)
        DB_DRIVER_CLASSPATH="/usr/share/java/postgresql.jar"
    ;;
    org.mariadb.jdbc.Driver)
        DB_DRIVER_CLASSPATH="/usr/share/java/mariadb-java-client.jar"
    ;;
    esac
fi
if [ -n "${DB_DRIVER_CLASSPATH}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --classpath=${DB_DRIVER_CLASSPATH}"
fi
if [ -n "${DB_URL}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --url=${DB_URL}"
fi
if [ -n "${DB_USERNAME}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --username=${DB_USERNAME}"
fi
if [ -n "${DB_PASSWORD}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --password=${DB_PASSWORD}"
fi

if [ -n "${DB_DEFAULT_SCHEMA_NAME}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --defaultSchemaName=${DB_DEFAULT_SCHEMA_NAME}"
fi

if [ -n "${DB_SCHEMAS}" ]; then
    LIQUIBASE_OPTS="${LIQUIBASE_OPTS} --schemas=${DB_SCHEMAS}"
fi
echo $LIQUIBASE_OPTS
/liquibase/liquibase $LIQUIBASE_OPTS $*