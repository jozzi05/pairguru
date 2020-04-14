module Api
  module V1
    class MoviesController < Api::V1::BaseApi
      def index
        render 200
      end
    end
  end
end
