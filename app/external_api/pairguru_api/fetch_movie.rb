module PairguruApi
  class FetchMovie
    include Dry::BaseAction

    MOVIE_URL = "#{DOMAIN}/api/v1/movies/%<movie_title>s".freeze
    POSTER_URL = "#{DOMAIN}%<poster>s".freeze

    def call(title)
      response = yield ApiClient.get(url(title))
      attributes = response.dig(:data, :attributes)
      serialized_movie = serialize_movie_attributes(**attributes)
      Success(serialized_movie)
    end

    private

    def url(title)
      format(MOVIE_URL, movie_title: encode(title))
    end

    def encode(string)
      ERB::Util.url_encode(string)
    end

    def serialize_movie_attributes(title:, plot:, poster:, rating:, **)
      {
        title: title,
        rating: rating,
        plot: plot,
        poster: format(POSTER_URL, poster: poster)
      }
    end

    private_constant :MOVIE_URL, :POSTER_URL
  end

  private_constant :FetchMovie
end
