require 'appium_lib'

Before do |scenario|
  require 'tmpdir'
  tags = scenario.source_tag_names

  if tags.include?('@android_chrome')
    caps = {
      platformName: "Android",
      deviceName: "0084665686", # seu device real
      browserName: "Chrome",
      'appium:automationName': "uiautomator2",
      'chromedriverExecutable': '/usr/local/bin/chromedriver140'
    }

    server_url = "http://localhost:4726"

  elsif tags.include?('@android')
    caps = {
      platformName: "Android",
      deviceName: "0084665686", # seu device real
      'appium:automationName': "uiautomator2",
      appPackage: "com.google.android.calculator",
      appActivity: "com.android.calculator2.Calculator"
    }
    server_url = "http://localhost:4444/wd/hub"

  else
    user_data_dir = Dir.mktmpdir("chrome-profile-")
    chrome_args = [
      '--headless',
      '--disable-gpu',
      '--no-sandbox',
      '--window-size=375,812',
      "--user-data-dir=#{user_data_dir}"
    ]
    caps = {
      platformName: "linux",
      browserName: "chrome",
      'appium:automationName': "chromium",
      'goog:chromeOptions': {
        args: chrome_args
      }
    }
    server_url = "http://localhost:4444/wd/hub"
  end

  opts = {
    caps: caps,
    appium_lib: {
      server_url: server_url
    },
  }
  begin
  $driver = Appium::Driver.new(opts, true)
  $driver.start_driver
  rescue => e
    puts "Erro ao iniciar o driver: #{e.class} - #{e.message}"
    puts e.backtrace
    raise e
  end
end