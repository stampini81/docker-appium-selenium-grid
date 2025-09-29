#!/bin/bash

# Debug PATH
echo "PATH at entry: $PATH"
# Garante PATH mínimo
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH"
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

sleep 2


# Inicia o Appium Server para Android em background com download automático do Chromedriver
appium --allow-insecure uiautomator2:chromedriver_autodownload --config /opt/selenium/appium-config.yml &

sleep 5

# Inicia o Selenium Node em foreground
java -jar /selenium-server.jar node --config /opt/selenium/node.toml
