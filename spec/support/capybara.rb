require 'capybara/poltergeist'
Capybara.asset_host = 'http://localhost:3000'
Capybara.default_selector = :css
Capybara.javascript_driver = :poltergeist
RSpec.configure do |config|
end
