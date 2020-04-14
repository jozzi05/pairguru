module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      include Api::V1::Movies::Errors
      include Import[
        :movies_repository,
        "api.v1.movie_serializer",
        "api.v1.fetch_movie"
      ]

      def index
        render json: movie_serializer.call(movies_repository.fetch_all)
      end

      def show
        fetch_movie.call(permitted_params) do |on_fetch_movie|
          on_fetch_movie.success(&on_fetch_movie_success)
          on_fetch_movie.failure(:validation_error, &on_fetch_movie_failure)
          on_fetch_movie.failure(:movie_not_found, &on_fetch_movie_failure)
        end
      end

      private

      def on_fetch_movie_success
        ->(movie) { render json: movie_serializer.call(movie) }
      end

      def on_fetch_movie_failure
        ->(_failure) { respond_with_errors(movie_not_found_error, status: 404) }
      end
    end
  end
end
