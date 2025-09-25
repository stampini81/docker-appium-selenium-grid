# Use uma imagem base do Node.js para ter o npm/npx
FROM node:current-alpine3.22

# Variáveis de ambiente
ENV SELENIUM_VERSION=4.22.0
ENV APPIUM_PORT=4723

# Instala Java e outras ferramentas úteis
RUN apk add --no-cache \
    chromium \
    chromium-chromedriver \
    openjdk17-jre \
    wget

# Instala Appium e o driver do Chromium
RUN npm install -g appium@latest
RUN appium driver install chromium

# Define variáveis de ambiente (às vezes necessárias p/ Selenium/Appium)
ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROMEDRIVER_PATH=/usr/bin/chromedriver

RUN mkdir -p /root/.appium/node_modules/appium-chromium-driver/node_modules/appium-chromedriver/chromedriver/linux \
    && cp /usr/bin/chromedriver /root/.appium/node_modules/appium-chromium-driver/node_modules/appium-chromedriver/chromedriver/linux/chromedriver

# Baixa o Selenium Server
RUN wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-${SELENIUM_VERSION}/selenium-server-${SELENIUM_VERSION}.jar -O selenium-server.jar

# Define o diretório de trabalho dentro do contêiner
WORKDIR /opt/selenium

# Copia os arquivos de configuração e o script de inicialização
COPY ./node.toml .
COPY ./appium-config.yml .
COPY ./entrypoint.sh .

# Dá permissão de execução para o script
RUN chmod +x entrypoint.sh

# Expõe a porta do Appium (opcional, bom para debug)
EXPOSE ${APPIUM_PORT}

# Define o script de inicialização como o ponto de entrada do contêiner
ENTRYPOINT ["./entrypoint.sh"]