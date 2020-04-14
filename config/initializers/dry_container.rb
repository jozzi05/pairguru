module Container
  extend Dry::Container::Mixin

  register :fetch_movie do
    PairguruApi.method(:fetch_movie)
  end

  register :logger, Rails.logger

  register :movies_repository do
    MoviesRepository.new
  end

  namespace("api.v1") do
    register "movie_serializer" do
      ->(movie) { Api::V1::MovieSerializer.new(movie).serialized_json }
    end

    register "fetch_movie_contract" do
      Api::V1::FetchMovieContract.new
    end

    register "fetch_movie" do
      Api::V1::FetchMovie.new
    end
  end
end

Import = Dry::AutoInject(Container)
