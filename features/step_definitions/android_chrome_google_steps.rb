Given('que estou na página inicial do Google no Chrome Android') do
  $driver.get('https://www.google.com')
end

When('eu pesquiso por {string}') do |termo|
  search_box = $driver.find_element(:css, '.gLFyf')
  search_box.send_keys(termo)
  search_box.submit
end



Then('devo ver resultados relacionados a {string}') do |termo|
  wait = Selenium::WebDriver::Wait.new(timeout: 20)
  # Tenta fechar overlay de consentimento do Google se aparecer
  begin
    consent_btn = wait.until { $driver.find_element(:css, 'button[aria-label="Aceitar tudo"]') }
    consent_btn.click
  rescue Selenium::WebDriver::Error::TimeoutError, Selenium::WebDriver::Error::NoSuchElementError
    # Não apareceu overlay, segue normalmente
  end
  # Busca o termo em todo o texto da página
  body = wait.until { $driver.find_element(:tag_name, 'body') }
  expect(body.text.downcase.include?(termo.downcase)).to be true
end
