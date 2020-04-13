module ApiClient
  class << self
    include Dry::Monads[:result]

    def get(_url)
      Failure(:incorrect_url)
    end
  end
end
