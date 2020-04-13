module ApiClient
  class << self
    include Dry::Monads[:result]

    def get(url)
      response = Faraday.get(URI.parse(url))
      return failure_response(response) unless response.success?

      Success(parse_response(response))
    rescue URI::InvalidURIError
      Failure(:incorrect_url)
    rescue Faraday::ConnectionFailed => e
      api_call_error("#{e.class} - #{e.message}")
    end

    private

    def parse_response(response)
      Oj.load(response.body, symbol_keys: true)
    end

    def failure_response(response)
      api_call_error("status:[#{response.status}] - body[#{response.body}]")
    end

    def api_call_error(message)
      Failure([:external_api_call_error, message])
    end
  end
end
