module Api
  module V1
    class FetchMoviesList
      include Dry::BaseAction
      include Import[
        "movies_repository",
        "api.v1.fetch_movies_list_contract"
      ]

      def call(input)
        params = yield validate_input(input)
        fetch_movies(params)
      end

      private

      def validate_input(input)
        fetch_movies_list_contract.validate(input)
      end

      def fetch_movies(include: nil)
        movies = movies_repository.fetch_all_with(include)
        Success(movies: movies, include: include)
      end
    end
  end
end
