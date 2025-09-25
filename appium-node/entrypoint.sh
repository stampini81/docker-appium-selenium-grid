#!/bin/sh

# Inicia o Appium Server em background na porta 4723
# O & no final é crucial para rodar em background
appium --config /opt/selenium/appium-config.yml &

# Aguarda alguns segundos para garantir que o Appium iniciou completamente
sleep 5

# Inicia o Selenium Node em foreground.
# Este processo manterá o contêiner rodando.
# Ele usa o .jar que baixamos no Dockerfile e o .toml que copiamos.
java -jar /selenium-server.jar node --config /opt/selenium/node.toml