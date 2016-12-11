FROM debian:wheezy

ENV DEBIAN_FRONTEND=noninteractive

EXPOSE 8010 8100 9010 9100 110 143 993 25 443

# http://www.stalker.com/pub/CommuniGatePro/
# последние версии
# http://mail.stalker.com/guide/russian/default.html#Current
# положить нужную версию возле Dockerfile
COPY CGatePro-Linux_*.deb /tmp/

CMD "/start.sh"

RUN apt-get update -qqy && apt-get upgrade -qqy \
## Set LOCALE to UTF8
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen  \
  && apt-get install -yqq  --no-install-recommends --no-install-suggests locales \
  && echo "LANG=\"ru_RU.UTF-8\"" > /etc/default/locale \
  && echo "LC_ALL=\"ru_RU.UTF-8\"" >> /etc/default/locale \
#  && locale-gen ru_RU.UTF-8 \
  && export LANG=ru_RU.UTF-8 \
  # удаляем все локали кроме этих
  && locale-gen --purge ru_RU.UTF-8 en_US.UTF-8 \
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
### bareos-filedaemon
  && apt-get install -yqq  --no-install-recommends ca-certificates wget \
  && export DIST=Debian_7.0 \
  && export URL=http://download.bareos.org/bareos/release/latest/$DIST/ \
  && echo "deb $URL /\n" > /etc/apt/sources.list.d/bareos.list \
  && wget -O - -q $URL/Release.key | apt-key add - \
# install Bareos packages 
  && apt-get update \
  && apt-get install -yqq  --no-install-recommends bareos-filedaemon \
  && rm -rf /etc/bareos/bareos-fd.d \
# удаление ненужного
  && apt-get -y autoremove

COPY [ "add", "/" ]
