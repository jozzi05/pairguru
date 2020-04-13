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
      let(:id) { "super_random_id" }

      it "confirms connection" do
        subscribe(id: id)
        expect(subscription).to be_confirmed
      end

      it "creates correct stream" do
        subscribe(id: id)
        assert_has_stream "fetch_movie_channel_#{id}"
      end
    end
  end
end
