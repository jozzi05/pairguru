require "webmock/rspec"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!

  config.ignore_localhost = true
  driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }
  config.ignore_hosts(*driver_hosts)
end
