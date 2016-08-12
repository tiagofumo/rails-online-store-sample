RSpec.configure do |config|
  config.extend ControllerMacros, :type => :controller
  config.include CapybaraHelpers, type: :feature
end
