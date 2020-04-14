module Api
  module V1
    class BaseApi < ActionController::API
      def respond_with_errors(*errors, status:)
        render json: { errors: errors }, status: status
      end
    end
  end
end
