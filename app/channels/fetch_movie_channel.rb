class FetchMovieChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:id]

    stream_from "fetch_movie_channel_#{params[:id]}"
  end

  def fetch_movie(data)
    FetchMovieJob.perform_later(id: params[:id], title: data["title"]) if data["title"]
  end
end
