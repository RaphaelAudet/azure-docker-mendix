# Dockerfile
#
# VERSION               0.2

FROM debian:jessie-backports
MAINTAINER Raphael Audet <raphael.audet@mendix.com>

RUN apt-key adv --fetch-keys http://packages.mendix.com/mendix-debian-archive-key.asc
RUN echo "deb http://packages.mendix.com/platform/debian/ jessie main" > /etc/apt/sources.list.d/mendix.list

RUN apt-get update && apt-get install -y --no-install-recommends m2ee-tools openjdk-8-jre-headless postgresql-client procps vim-nox curl && apt-get clean

RUN useradd -m mendix -b /srv && cd /srv/mendix && mkdir .m2ee data model runtimes web
RUN cd /srv/mendix/data && mkdir database files model-upload log tmp

COPY start.sh /start.sh
COPY m2ee.azure.yaml /srv/mendix/.m2ee/m2ee.yaml
RUN chmod +x /start.sh

RUN chown -R mendix:mendix /srv/mendix

ENV MXDATA /srv/mendix/data

EXPOSE 8000

ENTRYPOINT ["/start.sh"]

USER mendix
CMD ["start"]
