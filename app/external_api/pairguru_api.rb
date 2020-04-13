module PairguruApi
  DOMAIN = "https://pairguru-api.herokuapp.com".freeze

  def self.fetch_movie(movie_title, &block)
    FetchMovie.new.call(movie_title, &block)
  end

  private_constant :DOMAIN
end
