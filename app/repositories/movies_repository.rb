class MoviesRepository
  def fetch_all
    Movie.all
  end

  def find(id:)
    Movie.find_by(id: id)
  end
end
