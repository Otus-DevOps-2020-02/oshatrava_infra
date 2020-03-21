# oshatrava_infra
oshatrava Infra repository

# Homework 3 (GCP | VPN)

## GCI VM's
~~~~~
bastion_IP = 34.89.232.72
someinternalhost_IP = 10.132.0.3
~~~~~

## Самостоятельное задание 1:
*Исследовать способ подключения к someinternalhost в одну
команду из вашего рабочего устройства.*

````bash
ssh -t -A olegshatrava@34.89.232.72 ssh 10.132.0.3
````

## Дополнительное задание:
*Предложить вариант решения для подключения из консоли при
помощи команды вида **ssh someinternalhost** из локальной
консоли рабочего устройства.*

````bash
~/.ssh/config

Host someinternalhost
  HostName 10.132.0.3
  ProxyJump olegshatrava@34.89.232.72
````

## Дополнительное задание 2:
*С помощью сервисов sslip.io/xip.io и Let's Encrypt реализуйте
использование валидного сертификата для панели управления
VPN-сервера.*

https://34.89.232.72.xip.io/


# Homework 4 (GCP)
~~~~~
testapp_IP = 34.91.73.232
testapp_port = 9292
~~~~~

Create VM instance
~~~~~
$ gcloud compute instances create reddit-app \
    --boot-disk-size=10GB \
    --image-family ubuntu-1604-lts \
    --image-project=ubuntu-os-cloud \
    --machine-type=g1-small \
    --tags puma-server \
    --restart-on-failure \
    --metadata-from-file startup-script=startup.sh
~~~~~

Create firewall rule
~~~~~
$ gcloud compute firewall-rules create default-puma-server \
    --direction=ingress \
    --allow=tcp:9292 \
    --source-ranges=0.0.0.0/0 \
    --target-tags=puma-server
~~~~~
