# Dockerfile
#
# VERSION               0.2

FROM debian:jessie-backports
MAINTAINER Mendix Digital Ecosystems <digitalecosystems@mendix.com>

RUN apt-key adv --fetch-keys http://packages.mendix.com/mendix-debian-archive-key.asc
RUN echo "deb http://packages.mendix.com/platform/debian/ jessie main" > /etc/apt/sources.list.d/mendix.list

RUN apt-get update
RUN apt-get install -t jessie-backports  openjdk-8-jre-headless ca-certificates-java -y
RUN apt-get install -y --no-install-recommends postgresql-client procps netcat
RUN apt-get install -y m2ee-tools --force-yes && apt-get clean

RUN cd /root && mkdir .m2ee data model runtimes web && cd data && mkdir database files model-upload log tmp
RUN mkdir -p /root/.java/.userPrefs/com/mendix/core

RUN mkdir -p /opt/mendix

COPY vpcdeployer.mda /root/data/model-upload/application.mda
COPY vpcdeployer.yaml /root/.m2ee/m2ee.yaml

COPY start.sh /start.sh
RUN chmod +x /start.sh
COPY m2ee.experimental /usr/bin/m2ee

COPY vpc_deployer.policy /root/vpc_deployer.policy

ENV MXDATA /root/data

EXPOSE 9000

ENTRYPOINT ["/start.sh"]
