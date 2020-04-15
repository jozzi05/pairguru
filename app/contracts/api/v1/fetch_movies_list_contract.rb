module Api
  module V1
    class FetchMoviesListContract < BaseContract
      params do
        optional(:include).value(:string, included_in?: ["genre"])
      end
    end
  end
end
