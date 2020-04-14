module RequestsModule
  def parsed_json
    raise "The response is missing, make sure the call has been performed." unless response

    Oj.load(response.body, symbol_keys: true)
  end
end

RSpec.configure do |config|
  config.include RequestsModule, type: :request
end

