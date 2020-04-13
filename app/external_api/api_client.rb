module ApiClient
  class << self
    include Dry::Monads[:result]

    def get(url)
      response = Faraday.get(URI.parse(url))
      api_call_error("status:[#{response.status}] - body[#{response.body}]")
    rescue URI::InvalidURIError
      Failure(:incorrect_url)
    rescue Faraday::ConnectionFailed => e
      api_call_error("#{e.class} - #{e.message}")
    end

    private

    def api_call_error(message)
      Failure([:external_api_call_error, message])
    end
  end
end
