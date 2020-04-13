module StubMonadsMethods
  include Dry::Monads[:result]

  def stubbed_success
    proc do |*args, &block|
      result = Success(yield(*args))
      if block
        Dry::Matcher::ResultMatcher.call(result, &block)
      else
        result
      end
    end
  end
end

RSpec.configure do |config|
  config.include StubMonadsMethods, with_dry_monads_stubs: true
end
