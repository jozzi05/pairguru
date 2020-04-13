module Container
  extend Dry::Container::Mixin

  register :fetch_movie do
    PairguruApi.method(:fetch_movie)
  end

  register :logger, Rails.logger
end
