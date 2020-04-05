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


# Homework 5 (Packer)
1. Build base image
~~~~
$ packer build -var-file=variables.json ubuntu16.json
~~~~

2. Build an immutable `reddit-full` image
~~~~
$ packer build imuutable.json
~~~~

3. Running the `reddit-full` instance
~~~~
$ sh ./config-scripts/create-reddit-vm.sh
~~~~


# Homework 6 (Terraform)
1. Для добавления ssh-ключей нескольких пользователей в метаданные проекта, создан `resource "google_compute_project_metadata_item" "ssh-keys"`:
~~~~
resource "google_compute_project_metadata_item" "ssh-keys" {
  key = "ssh-keys"
  value = "olegshatrava:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
}
~~~~

2. При добавление ssh-ключа через веб интерфейс, `terraform` удалит его после очередного применения конфигурации, так как в стейте терафора нету информации о создание ключа, который был добавлен через веб интерфейс. Чтобы исключить подобные проблемы, необходимо описывать все ключи в конфигарции `main.tf`

3. Создан файл `lb.tf` и описаны конфиг для работы HTTP Load Balancer на несколько инстанцев.

4. Для избежания дублирования кода можно использовать переменную `count`:
~~~~~
resource "google_compute_instance" "reddit_app_instance" {
  count        = var.vm_instance_count
  name         = "reddit-app${count.index}"
}
~~~~~

# Homework 7 (Terraform module)
1. Созданы модули `app`, `db`, `vpc`.
2. Cозданы окружения `stage`, `prod`, с ограничением доступа к `ssh` по допустимым списком ip адресов указаным в `source_ranges`.
3. Каждое из окружений имеет удаленное хранение стейта в GCI.
