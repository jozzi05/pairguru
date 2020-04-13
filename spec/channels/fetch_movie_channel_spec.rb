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

      before { subscribe(id: id) }

      it "confirms connection" do
        expect(subscription).to be_confirmed
      end

      it "creates correct stream" do
        assert_has_stream "fetch_movie_channel_#{id}"
      end
    end
  end

  describe "#fetch_movie" do
    subject(:fetch_movie) { perform(:fetch_movie, title: title) }

    let(:title) { "Pulp Fiction" }
    let(:id) { "subscription_id" }

    before { subscribe(id: id) }

    it "schedules fetch movie job" do
      expect { fetch_movie }
        .to have_enqueued_job(FetchMovieJob)
        .with(id: id, title: title)
    end
  end
end
