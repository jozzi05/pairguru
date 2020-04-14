module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      include Import[:movies_repository, "api.v1.movie_serializer"]

      def index
        render json: movie_serializer.call(movies_repository.fetch_all)
      end

      def show
        render status: 404
      end
    end
  end
end
