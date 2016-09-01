FROM openjdk:8
MAINTAINER sthysel@gmail.com
ENV DIST_MIRROR http://mirror.cc.columbia.edu/pub/software/apache/nifi
ENV NIFI_HOME /nifi
ENV VERSION 1.0.0

# Install necessary packages, create target directory, download and extract, and update the banner to let people know what version they are using
RUN mkdir ${NIFI_HOME}
RUN curl ${DIST_MIRROR}/${VERSION}/nifi-${VERSION}-bin.tar.gz | tar xvz -C ${NIFI_HOME} --strip-components=1 && \
                    sed -i -e "s|^nifi.ui.banner.text=.*$|nifi.ui.banner.text=Docker NiFi ${VERSION}|" ${NIFI_HOME}/conf/nifi.properties

EXPOSE  80 443 
VOLUME  ["/certs", "${NIFI_HOME}/flowfile_repository", "${NIFI_HOME}/database_repository", "${NIFI_HOME}/content_repository", "${NIFI_HOME}/provenance_repository"]

ADD ./sh/ /sh
CMD  ["/sh/start.sh"]
