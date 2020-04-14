module Api
  module V1
    class FetchMovie
      include Dry::BaseAction
      include Import[
        "movies_repository",
        "api.v1.fetch_movie_contract"
      ]

      def call(input)
        params = yield validate_input(input)
        fetch_movie(params)
      end

      private

      def validate_input(input)
        fetch_movie_contract.validate(input)
      end

      def fetch_movie(id:)
        movie = movies_repository.find(id: id)
        movie ? Success(movie) : Failure(:movie_not_found)
      end
    end
  end
end
