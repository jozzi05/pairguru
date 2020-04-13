module ApiClient
  class << self
    include Dry::Monads[:result]

    def get(url)
      Faraday.get(URI.parse(url))
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
