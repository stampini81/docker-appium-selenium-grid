@appium
Feature: Pesquisa no Google
  Para validar a integração Selenium Grid + Appium
  Como QA
  Quero pesquisar no Google e verificar o título da página

  Background:
    Given que estou na página inicial do Google

  Scenario: Pesquisar no Google
    When eu pesquiso por. "Appium"
    Then o título da página deve conter "Appium"