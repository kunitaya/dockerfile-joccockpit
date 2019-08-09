FROM openjdk:8
MAINTAINER kunitaya

# install mysql-client
RUN apt-get update && \
    apt-get -y install apt-utils mysql-client && \
    apt-get clean all

# download JOC Cockpit
ADD https://download.sos-berlin.com/JobScheduler.1.12/joc_linux.1.12.9.tar.gz /usr/local/src/
RUN test -e /usr/local/src/joc_linux.1.12.9.tar.gz && \
    tar zxvf /usr/local/src/joc_linux.1.12.9.tar.gz -C /usr/local/src/ && \
    rm -f /usr/local/src/joc_linux.1.12.9.tar.gz && \
    ln -s /usr/local/src/joc.1.12.9 /usr/local/src/joc
COPY joc_install.xml /usr/local/src/joc/install.xml

COPY init.sh /usr/local/bin/init_joc.sh
RUN chmod +x /usr/local/bin/init_joc.sh

EXPOSE 4446 40446

CMD ["/usr/local/bin/init_joc.sh"]
