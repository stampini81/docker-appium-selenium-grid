# Use uma imagem base do Node.js para ter o npm/npx
FROM node:current-alpine3.22

# Variáveis de ambiente
ENV SELENIUM_VERSION=4.22.0
ENV APPIUM_PORT=4723



# Instala Java, ferramentas Android, dependências do SDK, utilitários essenciais e dependências do chromedriver
RUN apk add --no-cache \
    android-tools \
    bash \
    coreutils \
    util-linux \
    busybox-extras \
    fluxbox \
    libc6-compat \
    openjdk17-jre \
    tigervnc \
    unzip \
    wget \
    xorg-server \
    xterm \
    glib \
    nspr \
    nss \
    libx11 \
    libxrender \
    libxtst \
    && if [ ! -e /bin/bash ]; then ln -s /usr/bin/bash /bin/bash; fi


# Instala o Android SDK
ENV ANDROID_SDK_ROOT=/opt/android-sdk-linux
ENV ANDROID_HOME=/opt/android-sdk-linux
RUN mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools" && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdline-tools.zip && \
    unzip -q /tmp/cmdline-tools.zip -d /tmp/cmdline-tools && \
    mv /tmp/cmdline-tools/cmdline-tools "$ANDROID_SDK_ROOT/cmdline-tools/latest" && \
    rm -rf /tmp/cmdline-tools /tmp/cmdline-tools.zip

# Instala plataformas e build-tools mínimos necessários
ENV PATH="$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools"
RUN yes | "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_SDK_ROOT" --licenses && \
    "$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager" --sdk_root="$ANDROID_SDK_ROOT" "platform-tools" "platforms;android-30" "build-tools;30.0.3"

# Instala Appium e o driver UiAutomator2 (Android)
RUN npm install -g appium@latest
RUN appium driver install uiautomator2


# Copia o chromedriver fornecido pelo usuário
COPY chromedriver140 /usr/local/bin/chromedriver140
RUN chmod +x /usr/local/bin/chromedriver140

# Baixa o Selenium Server
RUN wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-${SELENIUM_VERSION}/selenium-server-${SELENIUM_VERSION}.jar -O selenium-server.jar

RUN apk add --no-cache tigervnc fluxbox xterm xorg-server
WORKDIR /opt/selenium

COPY ./node.toml .
COPY ./appium-config.yml .
COPY ./entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE ${APPIUM_PORT}
EXPOSE 5900

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
