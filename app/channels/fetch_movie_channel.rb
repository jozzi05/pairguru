class FetchMovieChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:id]

    stream_from "fetch_movie_channel_#{params[:id]}"
  end
end
