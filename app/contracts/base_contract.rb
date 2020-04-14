require "dry/validation"

Dry::Validation.load_extensions(:monads)

class BaseContract < Dry::Validation::Contract
  include Dry::Monads[:result]

  config.messages.backend = :i18n

  def validate(input)
    call(input).to_monad.either(
      ->(success) { Success(success.to_h) },
      ->(failure) { Failure([:validation_error, failure.errors.to_h]) }
    )
  end
end
