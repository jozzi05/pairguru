module PairguruApi
  class FetchMovie
    MOVIE_URL = "#{DOMAIN}/api/v1/movies/%<movie_title>s".freeze

    def call(title)
      ApiClient.get(format(MOVIE_URL, movie_title: title))
    end
  end
end