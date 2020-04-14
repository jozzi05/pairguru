module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      include Import[:movies_repository, :movie_serializer]

      def index
        render json: movie_serializer.call(movies_repository.fetch_all)
      end
    end
  end
end
