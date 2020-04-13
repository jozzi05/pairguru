module ApiClient
  class << self
    include Dry::Monads[:result]

    def get(_url)
      Failure()
    end
  end
end
