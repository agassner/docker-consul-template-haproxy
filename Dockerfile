FROM haproxy:1.6

RUN apt-get update \
		&& apt-get install -y unzip

ENV CONSUL_TEMPLATE_VERSION="0.14.0"
ENV CONSUL_TEMPLATE_FILE="consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip"
ENV CONSUL_TEMPLATE_URL="https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/${CONSUL_TEMPLATE_FILE}"

ADD $CONSUL_TEMPLATE_URL /tmp/
RUN unzip /tmp/$CONSUL_TEMPLATE_FILE -d /usr/local/bin \
		&& rm /tmp/$CONSUL_TEMPLATE_FILE

COPY files/*.sh /
COPY files/consul-config.hcl /
COPY files/haproxy/* /etc/haproxy/

ENTRYPOINT ["/startup.sh"]