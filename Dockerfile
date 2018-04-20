FROM microsoft/mssql-server-linux:latest
LABEL version="1.0"
LABEL description="Extension of the microsoft/mssql-server-linux docker image to support initdb scripts, supporting latest tag"
LABEL maintainer="Paolo Furini"

HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 CMD "sqlcmd -U sa -P $SA_PASSWORD -Q 'SELECT 1;' &> /dev/null"

VOLUME /docker-entrypoint-initdb.d

RUN ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd \
    && ln -s /opt/mssql-tools/bin/bcp /usr/local/bin/bcp
COPY docker-entrypoint.sh /usr/local/bin/
COPY docker-entrypoint-initdb.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]