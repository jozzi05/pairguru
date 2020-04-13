require "dry/monads/do"
require "dry/monads/result"
require "dry/matcher/result_matcher"

module Dry
  module BaseAction
    extend ActiveSupport::Concern

    included do
      include Dry::Monads[:result, :do]
      include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)
    end
  end
end
