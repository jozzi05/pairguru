module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      include Api::V1::Movies::Errors
      include Import[
        "api.v1.movie_serializer",
        "api.v1.fetch_movie",
        "api.v1.fetch_movies_list"
      ]

      def index
        fetch_movies_list.call(permitted_params) do |on_fetch_movie|
          on_fetch_movie.success(&on_fetch_movies_list_success)
          on_fetch_movie.failure(:validation_error, &on_validation_error)
        end
      end

      def show
        fetch_movie.call(permitted_params) do |on_fetch_movie|
          on_fetch_movie.success(&on_fetch_movie_success)
          on_fetch_movie.failure(:validation_error, &on_validation_error)
          on_fetch_movie.failure(:movie_not_found) { respond_with_errors(movie_not_found_error, status: 404) }
        end
      end

      private

      def on_fetch_movies_list_success
        ->(movies:, include:) { render json: movie_serializer.call(movies, include) }
      end

      def on_fetch_movie_success
        ->(movie:, include:) { render json: movie_serializer.call(movie, include) }
      end

      def on_validation_error
        ->((_key, errors)) { respond_with_errors(*validation_errors(errors), status: 400) }
      end
    end
  end
end
