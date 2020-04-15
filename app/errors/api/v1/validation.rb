module Api
  module V1
    module Validation
      def validation_errors(errors_codes)
        errors_codes.map { |code:| send(code) }
      end
    end
  end
end
