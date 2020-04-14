module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      def index
        render json: { movies: [] }
      end
    end
  end
end
