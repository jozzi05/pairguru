module Container
  extend Dry::Container::Mixin

  register :fetch_movie do
    PairguruApi.method(:fetch_movie)
  end

  register :logger, Rails.logger

  register :movies_repository do
    MoviesRepository.new
  end

  register :movie_serializer do
    ->(movie) { MovieSerializer.new(movie).serialized_json }
  end
end

Import = Dry::AutoInject(Container)
