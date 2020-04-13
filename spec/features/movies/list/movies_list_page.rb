require_relative "movie_row_page"

class MoviesListPage < BasePage
  include Rails.application.routes.url_helpers

  def initialize(page)
    @movies_table = page.find("table")
  end

  def has_row_with_movie(movie, movie_api_response)
    movie_row(movie.title)
      .has_title_with_link(title: movie.title, href: movie_path(movie))
      .has_genre_with_link(genre: movie.genre.name, href: movies_genre_path(movie.genre))
      .has_description(movie.description)
      .has_plot(movie_api_response[:plot])
      .has_poster(movie_api_response[:poster])
      .has_rating(movie_api_response[:rating])
  end

  private

  attr_reader :movies_table

  def movie_row(title)
    movies_table
      .find("tr[data-movie-title='#{title}']")
      .then(&MovieRowPage)
  end
end
