RSpec.shared_context :movie_matchers do
  def movie_without_relations(movie)
    {
      id: movie.id.to_s,
      type: "movie",
      attributes: {
        title: movie.title
      },
      relationships: {}
    }
  end

  def movie_with_relations(movie)
    {
      id: movie.id.to_s,
      type: "movie",
      attributes: {
        title: movie.title
      },
      relationships: {
        genre: {
          data: {
            id: movie.genre.id.to_s,
            type: "genre"
          }
        }
      }
    }
  end

  def matching_genre(genre)
    {
      id: genre.id.to_s,
      type: "genre",
      attributes: {
        name: genre.name,
        movies_count: genre.movies.count
      }
    }
  end
end
