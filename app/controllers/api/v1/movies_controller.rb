module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      include Api::V1::Movies::Errors
      include Import[:movies_repository, "api.v1.movie_serializer"]

      def index
        render json: movie_serializer.call(movies_repository.fetch_all)
      end

      def show
        respond_with_errors(movie_not_found_error, status: 404)
      end
    end
  end
end
