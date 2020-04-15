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
      ->(resources, include) do
        Api::V1::MovieSerializer.new(resources, params: { include: include }, include: [:genre])
      end
    end

    register "fetch_movie_contract" do
      Api::V1::FetchMovieContract.new
    end

    register "fetch_movies_list_contract" do
      Api::V1::FetchMoviesListContract.new
    end

    register "fetch_movie" do
      Api::V1::FetchMovie.new
    end

    register "fetch_movies_list" do
      Api::V1::FetchMoviesList.new
    end
  end
end

Import = Dry::AutoInject(Container)
