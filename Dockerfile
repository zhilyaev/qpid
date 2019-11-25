FROM ubuntu:18.04
ARG qpid_user_pass='TERsiXuB'
ARG qpid_admin_pass='8fM12c09'
RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository ppa:qpid/released \
    && apt-get update \
    && apt install -y qpidd qpid-tools sasl2-bin \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /var/lib/qpidd \
    && echo $qpid_user_pass | saslpasswd2 -p -c -f /var/lib/qpidd/qpidd.sasldb -u QPID user \
    && echo $qpid_admin_pass  | saslpasswd2 -p -c -f /var/lib/qpidd/qpidd.sasldb -u QPID admin \
    && chown qpidd: /var/lib/qpidd/qpidd.sasldb \
    && mkdir -p /var/run/qpid \
    && chown qpidd: /var/run/qpid \
    && echo "\
       #!/bin/bash\n\
       echo 'I am alive'\n\
       sleep 5\n\
       echo 'I am starting qpid-config'\n\
       qpid-config --durable add queue my_queue su\n\
       echo 'The queues created'\n" \
       > /entrypoint.sh \
    && chmod +x entrypoint.sh

EXPOSE 5672
ENTRYPOINT /entrypoint.sh & qpidd --log-enable=info+ --auth=yes --realm=QPID --port=5672
