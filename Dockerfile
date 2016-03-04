FROM ubuntu:latest
MAINTAINER Matheus C. Candido  <matheus@mcassiano.com>

ENV DEBIAN_FRONTEND noninteractive

# Install Supervisor and RabbitMQ.

RUN apt-get -y  update
RUN apt-get install -y wget
RUN wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc -O /tmp/rabbitmq-signing-key-public.asc
RUN apt-key add /tmp/rabbitmq-signing-key-public.asc
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" >> /etc/apt/sources.list
RUN echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list

RUN apt-get -y update
RUN apt-get install -y openssh-server supervisor
RUN apt-get install -y rabbitmq-server
RUN rabbitmq-plugins enable rabbitmq_management

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d"]

COPY rabbitmq.sh /opt/rabbitmq.sh
COPY rabbitmq.conf /etc/supervisor/conf.d/rabbitmq.conf
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

# Define working directory.
WORKDIR /etc/supervisor/conf.d

EXPOSE 5672 15672

# ------------------------------------------------------------------------------
# Start supervisor, define default command.
CMD ["supervisord", "-n"]
