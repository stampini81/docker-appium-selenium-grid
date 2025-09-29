@android_chrome
Feature: Busca no Google via Chrome Android
  Como usuário Android
  Quero buscar no Google usando o Chrome do celular

  Scenario: Buscar Appium Android no Google
    Given que estou na página inicial do Google no Chrome Android
    When eu pesquiso por "Appium Android"
    Then devo ver resultados relacionados a "Appium Android"
