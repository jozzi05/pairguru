require "rails_helper"

RSpec.describe FetchMovieChannel, type: :channel do
  describe "#subscription" do
    context "with missing id" do
      it "rejects connection" do
        subscribe
        expect(subscription).to be_rejected
      end
    end
  end
end
