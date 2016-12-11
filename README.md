[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/github.com/ErshovSergey/master/LICENSE) ![Language](https://img.shields.io/badge/language-bash-yellowgreen.svg)
# CommunigatePro6_debian7_bareos16_in_docker
[CommunigatePro](https://www.communigate.com/ru/default.html) [версии 6](http://www.stalker.com/pub/CommuniGatePro/6.1/) запущенный поверх [Debian 7](https://www.debian.org/releases/wheezy/), также клиент [bareos](https://www.bareos.org/en/) для резервного копирования. Всё это в контейнере [docker](https://www.docker.com/).
## Эксплуатация
Эксплуатация Communigate проще при запуске в контейнере docker. Для резервного копирования можно использовать bareos
##Описание
Debian 7 обновляется, устанавливается та версия CommunigatePro, которая находится рядом Dockerfile. 
Устанавливается клиент bareos.
Настройки bareos (файл */etc/bareos/bareos-fd.d/client/myself.conf* - менять до сборки контейнера). 
Каталог данных CommunigatePro хранится вне контейнера.

#Эксплуатация данного проекта.
##Клонируем проект
```shell
git clone https://github.com/ErshovSergey/CommunigatePro6_debian7_bareos16_in_docker.git
```
##Собираем
```shell
cd nod32-mirror/
docker build --rm=true --force-rm --tag=ershov/communigatepro .
```
Создаем папку для хранения настроек и обновлений вне контейнера
```shell
export SHARE_DIR="/opt/docker_data/NOD32MIRROR" && mkdir -p $SHARE_DIR
```
##Запускаем
Для корректной работы CommunigatePro необходим статический адрес, поэтому создаем сеть docker
```shell
docker network create --subnet 192.168.1.0/24 --gateway 192.168.1.1 CommunigatePro
```
Данные будем хранить в каталоге
```shell
export SHARE_DIR="/home/CommunigatePro"
```
Запускать на адресе локальной сети
```shell
export ip_addr=192.168.0.184
```
Запускаем контейнер (расшариваемые порты добавляем по необходимости)
```shell
docker run --name CommunigatePro \
--ulimit nproc=2048:2048 \
-di --restart=always \
-h communigategate \
--net CommunigatePro \
--ip="192.168.1.5" \
-v $SHARE_DIR:/var/CommuniGate/ \
-p $ip_addr:8010:8010 \
-p $ip_addr:9010:9010 \
-p $ip_addr:9100:9100 \
-p $ip_addr:110:110 \
-p $ip_addr:993:993 \
-p $ip_addr:25:25 \
-p $ip_addr:465:465 \
-p $ip_addr:5222:5222 \
-p $ip_addr:9102:9102 \
-d ershov/cgp
```
##Настройка
Все настройки производятся через web интерфейс http://$ip_addr


### <i class="icon-upload"></i>Ссылки
 - [CommunigatePro](https://www.communigate.com/ru/default.html) [версии 6](http://www.stalker.com/pub/CommuniGatePro/6.1/) 
 - [Debian 7](https://www.debian.org/releases/wheezy/)
 - клиент [bareos](https://www.bareos.org/en/) 
 - [docker](https://www.docker.com/)
 - [Запись в блоге](https://blog.erchov.ru/)
 - [Редактор readme.md](https://stackedit.io/)

### <i class="icon-refresh"></i>Лицензия MIT

> Copyright (c) 2016 &lt;[ErshovSergey](http://github.com/ErshovSergey/)&gt;

> Данная лицензия разрешает лицам, получившим копию данного программного обеспечения и сопутствующей документации (в дальнейшем именуемыми «Программное Обеспечение»), безвозмездно использовать Программное Обеспечение без ограничений, включая неограниченное право на использование, копирование, изменение, добавление, публикацию, распространение, сублицензирование и/или продажу копий Программного Обеспечения, также как и лицам, которым предоставляется данное Программное Обеспечение, при соблюдении следующих условий:

> Указанное выше уведомление об авторском праве и данные условия должны быть включены во все копии или значимые части данного Программного Обеспечения.

> ДАННОЕ ПРОГРАММНОЕ ОБЕСПЕЧЕНИЕ ПРЕДОСТАВЛЯЕТСЯ «КАК ЕСТЬ», БЕЗ КАКИХ-ЛИБО ГАРАНТИЙ, ЯВНО ВЫРАЖЕННЫХ ИЛИ ПОДРАЗУМЕВАЕМЫХ, ВКЛЮЧАЯ, НО НЕ ОГРАНИЧИВАЯСЬ ГАРАНТИЯМИ ТОВАРНОЙ ПРИГОДНОСТИ, СООТВЕТСТВИЯ ПО ЕГО КОНКРЕТНОМУ НАЗНАЧЕНИЮ И ОТСУТСТВИЯ НАРУШЕНИЙ ПРАВ. НИ В КАКОМ СЛУЧАЕ АВТОРЫ ИЛИ ПРАВООБЛАДАТЕЛИ НЕ НЕСУТ ОТВЕТСТВЕННОСТИ ПО ИСКАМ О ВОЗМЕЩЕНИИ УЩЕРБА, УБЫТКОВ ИЛИ ДРУГИХ ТРЕБОВАНИЙ ПО ДЕЙСТВУЮЩИМ КОНТРАКТАМ, ДЕЛИКТАМ ИЛИ ИНОМУ, ВОЗНИКШИМ ИЗ, ИМЕЮЩИМ ПРИЧИНОЙ ИЛИ СВЯЗАННЫМ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ ИЛИ ИСПОЛЬЗОВАНИЕМ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ ИЛИ ИНЫМИ ДЕЙСТВИЯМИ С ПРОГРАММНЫМ ОБЕСПЕЧЕНИЕМ.

