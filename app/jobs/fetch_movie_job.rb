class FetchMovieJob < ApplicationJob
  queue_as :default

  def perform(params)
    params.symbolize_keys.tap do |id:, title:, **|
      PairguruApi.fetch_movie(title) do |on_fetch_movie|
        on_fetch_movie.success { |movie| ActionCable.server.broadcast("fetch_movie_channel_#{id}", movie) }
        on_fetch_movie.failure {}
      end
    end
  end
end
