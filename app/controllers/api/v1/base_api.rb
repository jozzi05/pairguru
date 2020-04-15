module Api
  module V1
    class BaseApi < ActionController::API
      def permitted_params
        params.permit!.to_hash
      end

      def respond_with_errors(*errors, status:)
        render json: { errors: errors }, status: status
      end
    end
  end
end
