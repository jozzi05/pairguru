require "rails_helper"

RSpec.describe FetchMovieChannel, type: :channel do
  describe "#subscription" do
    context "with missing id" do
      it "rejects connection" do
        subscribe
        expect(subscription).to be_rejected
      end
    end

    context "with present id" do
      it "confirms connection" do
        subscribe(id: "super_random_id")
        expect(subscription).to be_confirmed
      end
    end
  end
end
