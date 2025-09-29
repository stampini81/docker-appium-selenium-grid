@android
Feature: Abrir calculadora no Android
  Para validar a execução no node Android real
  Como QA
  Quero abrir a calculadora do celular e garantir que o app abre

  Scenario: Abrir a calculadora
    Given que o app Calculadora está instalado
    When eu abro o app Calculadora
    Then o app Calculadora deve estar visível

  Scenario: Somar dois números
    Given que o app Calculadora está instalado
    When eu abro o app Calculadora
    When eu somo 1 e 2 na calculadora
    Then o resultado deve ser "3"
