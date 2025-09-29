# features/step_definitions/SEU_ARQUIVO.rb

require 'selenium-webdriver'
require 'rspec/expectations'

Given('que estou na página inicial do Google') do
  # Usando uma variável de instância @driver em vez de global $driver é uma boa prática
  $driver.get('https://www.google.com')
end


When('eu pesquiso por. {string}') do |termo|
  # Cria um objeto de espera com timeout de 10 segundos
  wait = Selenium::WebDriver::Wait.new(timeout: 10)


  search_box = wait.until do
    $driver.find_element(:css, '.gLFyf')
  end

  search_box.send_keys(termo)
  search_box.submit
end


Then('o título da página deve conter {string}') do |texto|
  # Cria um objeto de espera para a condição do título
  wait = Selenium::WebDriver::Wait.new(timeout: 10)

  # Espera ATÉ que o título da página inclua o texto esperado
  wait.until { $driver.title.downcase.include?(texto.downcase) }

  # Após a espera, a asserção final confirma o resultado
  expect($driver.title.downcase).to include(texto.downcase)
end