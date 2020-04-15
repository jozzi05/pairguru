module Api
  module V1
    class GenreSerializer < BaseSerializer
      attributes :name

      attribute :movies_count do |object|
        object.movies.count
      end
    end
  end
end
