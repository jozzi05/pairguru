module Api
  module V1
    module Movies
      module Errors
        def movie_not_found_error
          { code: :resource_not_found, key: :id }
        end
      end
    end
  end
end
