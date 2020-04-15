module Api
  module V1
    class FetchMovieContract < BaseContract
      params do
        required(:id).value(:string)
        optional(:include).value(:string, included_in?: ["genre"])
      end
    end
  end
end
