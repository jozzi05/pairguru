RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, with_js: true) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1024, 1024]
  end

  config.before(:each, type: :system, with_ui: true) do
    driven_by :selenium, using: :chrome, screen_size: [1024, 1024]
  end
end
