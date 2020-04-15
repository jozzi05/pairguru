module Api
  module V1
    class MovieSerializer < BaseSerializer
      belongs_to :genre, if: proc { |_, params| params[:include] == "genre" }

      attributes :title
    end
  end
end
