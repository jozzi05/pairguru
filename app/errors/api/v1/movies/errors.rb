module Api
  module V1
    module Movies
      module Errors
        include Api::V1::Validation

        def movie_not_found_error
          { code: :resource_not_found, key: :id }
        end

        def include_must_be_one_of
          { code: :incorrect_include_value, key: :include, text: "allowed values: 'genre'" }
        end
      end
    end
  end
end
