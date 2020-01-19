#FROM debian:wheezy
FROM debian:stretch

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG='ru_RU.UTF-8' LANGUAGE='ru_RU.UTF-8' LC_ALL='ru_RU.UTF-8'

EXPOSE 8010 8100 9010 9100 110 143 993 25 443

# http://www.stalker.com/pub/CommuniGatePro/
# последние версии
#  ftp://ftp.communigate.com/pub/CommuniGatePro/
# http://mail.stalker.com/guide/russian/default.html#Current
# положить нужную версию возле Dockerfile
COPY CGatePro-Linux_*.deb /tmp/

CMD "/start.sh"

RUN apt-get update -qqy && apt-get upgrade -qqy \
# локаль
  && apt-get install -yqq  --no-install-recommends --no-install-suggests locales apt-utils \
  && echo ru_RU.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen \
  && apt-get install -yqq  --no-install-recommends --no-install-suggests \
            apt-utils debconf ca-certificates openssl binutils apt-utils debconf lsb-release \
# debug
#  && apt-get install -yqq --no-install-recommends --no-install-suggests \
#                     nano telnet procps sudo \
#  && echo "\nexport TERM=xterm" >> ~/.bashrc \
# timezone
  && echo "Europe/Moscow" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
  && dpkg -i /tmp/CGatePro-Linux_*.deb \
  && rm /tmp/CGatePro-Linux_*.deb \
# удаление ненужного
  && apt-get -y autoremove

COPY [ "add", "/" ]
