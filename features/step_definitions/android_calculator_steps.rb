Given('que o app Calculadora está instalado') do
  # Não faz nada, só garante que o device está pronto
end






When('eu abro o app Calculadora') do
  # Tenta abrir o app Calculadora, ignora erro se já estiver aberto
  begin
    $driver.execute_script('mobile: startActivity', {
      appPackage: 'com.google.android.calculator',
      appActivity: 'com.android.calculator2.Calculator'
    })
  rescue Selenium::WebDriver::Error::UnknownError => e
    raise unless e.message.include?('No intent supplied')
  end
end


Then('o app Calculadora deve estar visível') do
  # Verifica se um elemento da calculadora está presente
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  el = wait.until { $driver.find_element(:id, 'com.google.android.calculator:id/digit_1') }
  expect(el.displayed?).to be true
end

When('eu somo {int} e {int} na calculadora') do |a, b|
  $driver.find_element(:id, "com.google.android.calculator:id/digit_#{a}").click
  $driver.find_element(:id, 'com.google.android.calculator:id/op_add').click
  $driver.find_element(:id, "com.google.android.calculator:id/digit_#{b}").click
  $driver.find_element(:id, 'com.google.android.calculator:id/eq').click
end


Then('o resultado deve ser {string}') do |valor|
  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  resultado = nil
  begin
    resultado = wait.until { $driver.find_element(:id, 'com.google.android.calculator:id/result_final') }
  rescue Selenium::WebDriver::Error::TimeoutError, Selenium::WebDriver::Error::NoSuchElementError
    resultado = wait.until { $driver.find_element(:id, 'com.google.android.calculator:id/result_preview') }
  end
  expect(resultado.text).to eq(valor)
end
