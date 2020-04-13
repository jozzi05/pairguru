class FetchMovieChannel < ApplicationCable::Channel
  def subscribed
    reject
  end
end
