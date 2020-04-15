class MoviesRepository
  def fetch_all_with(include)
    Movie.includes(include).all
  end

  def find(id:)
    Movie.find_by(id: id)
  end
end
