module Api
  module V1
    class FetchMovieContract < BaseContract
      params do
        required(:id).value(:integer)
      end
    end
  end
end
