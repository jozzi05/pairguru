class FetchMovieChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:id]
  end
end
