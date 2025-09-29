# Execução de Testes Android e Google Chrome via Selenium Grid (Docker + Appium + Cucumber)

## Pré-requisitos

- **Windows 10/11** com WSL2 habilitado
- **Ubuntu** instalado no WSL2
- **Docker Desktop** instalado e rodando
- **Git** instalado
- **Ruby** e **rbenv** instalados no WSL2
- **usbipd-win** instalado no Windows (para compartilhar USB)
- **Device Android físico** com Depuração USB ativada
- **Chrome instalado no device Android**

## Instalação de dependências

### 1. Instale o usbipd-win no Windows
- Baixe o instalador MSI em: https://github.com/dorssel/usbipd-win/releases
- Instale normalmente.

### 2. Instale dependências no WSL2
```sh
sudo apt update
sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev git
# Instale rbenv e ruby-build se não tiver
# Siga instruções: https://github.com/rbenv/rbenv#installation
rbenv install 3.4.4
rbenv global 3.4.4
```

### 3. Clone o projeto e instale gems
```sh
git clone <repo>
cd docker-appium-selenium-grid(3)
bundle install
```

## Compartilhando o device Android com o WSL2

1. **Conecte o device Android via USB**
2. **No Windows PowerShell (como administrador):**
   ```powershell
   usbipd list
   usbipd attach --wsl --busid <BUSID>
   ```
   - O BUSID do seu device aparece no comando `usbipd list` (ex: 1-3)

3. **No WSL2:**
   ```sh
   adb devices
   # O device deve aparecer como "device"
   ```

## Subindo os containers do Selenium Grid e Appium

No WSL2, na pasta do projeto:
```sh
docker-compose up -d
```
- Aguarde todos os containers ficarem "Up".
- Acesse http://localhost:4444 para ver o Selenium Grid.

## Validando device dentro do container

1. Liste os containers:
   ```sh
   docker ps
   ```
2. Entre no container Android node:
   ```sh
   docker exec -it docker-appium-selenium-grid3-appium-node-android-1 bash
   adb devices
   # O device deve aparecer como "device"
   ```

## Executando os testes

No WSL2, na pasta do projeto:
```sh
bundle exec cucumber -t@android         # Testes nativos Android (Calculadora)
bundle exec cucumber -t@android_chrome # Testes Google Chrome Android
```

## Observações importantes
- Sempre mate o adb no WSL2 antes de subir o container:
  ```sh
  adb kill-server
  ```
- O device só pode ser controlado por um adb por vez (WSL2 ou container, nunca ambos ao mesmo tempo).
- Se o device aparecer como "unauthorized", aceite a depuração USB no celular.
- Para rodar o Appium com suporte a Chrome, o ChromeDriver deve ser compatível com a versão do Chrome do device.
- O Appium no container deve ser iniciado com `--allow-insecure chromedriver_autodownload` (já configurado no Dockerfile padrão).

## Resumo dos comandos principais

### No Windows PowerShell (admin):
```powershell
usbipd list
usbipd attach --wsl --busid <BUSID>
```

### No WSL2:
```sh
adb devices
adb kill-server
adb start-server
```

### No container Android node:
```sh
adb devices
```

### Subir containers:
```sh
docker-compose up -d
```

### Rodar testes:
```sh
bundle exec cucumber -t@android
bundle exec cucumber -t@android_chrome
```

---

Se algum passo falhar, verifique se o device aparece como "device" em todos os contextos (WSL2 e container) e se o Selenium Grid está "Up".
