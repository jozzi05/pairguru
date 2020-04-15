require "dry/validation"

Dry::Validation.load_extensions(:monads)

class BaseContract < Dry::Validation::Contract
  include Dry::Monads[:result]

  config.messages.backend = :i18n

  def validate(input)
    call(input).to_monad.either(
      ->(success) { Success(success.to_h) },
      ->(failure) { Failure([:validation_error, map_error_codes(failure.errors.to_h)]) }
    )
  end

  private

  def map_error_codes(errors, keys: [])
    errors.flat_map do |key, values|
      case key
      when Symbol then map_error_codes(values, keys: [*keys, key])
      when String then extract_base_validation_error(keys, key)
      else raise "Unsupported error type"
      end
    end
  end

  def extract_base_validation_error(keys, error)
    { code: "#{keys.join('_')}_#{error.split(':').first.parameterize(separator: '_')}".to_sym }
  end
end
