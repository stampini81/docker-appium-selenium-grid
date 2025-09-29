#!/bin/sh


# Configura senha padrão do VNC
mkdir -p /root/.vnc
echo "vncpassword" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd


# Garante que o diretório do X11 existe
mkdir -p /tmp/.X11-unix

# Inicia o VNC server
vncserver :0 -geometry 1280x800 -depth 24
export DISPLAY=:0

# Inicia o gerenciador de janelas
fluxbox &

# Aguarda alguns segundos para garantir que o ambiente gráfico está pronto
sleep 2

# Inicia o Appium Server em background na porta 4723
appium --config /opt/selenium/appium-config.yml &

# Aguarda alguns segundos para garantir que o Appium iniciou completamente
sleep 5

# Inicia o Selenium Node em foreground.
java -jar /selenium-server.jar node --config /opt/selenium/node.toml