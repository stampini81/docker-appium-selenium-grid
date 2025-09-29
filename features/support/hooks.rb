require 'cucumber'

# O $driver já é criado e iniciado no env.rb

After do
  $driver.driver_quit if $driver 
end