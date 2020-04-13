require "rails_helper"

RSpec.describe PairguruApi do
  describe "#fetch_movie" do
    subject(:fetch_movie) { described_class.fetch_movie(movie_title) }

    let(:returned_error) { fetch_movie.failure }

    context "with title missing in external api", vcr: { cassette_name: "pairguru/fetch_movie/shrek" } do
      let(:movie_title) { "Shrek" }

      it "returns failure" do
        expect(fetch_movie).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_error).to eq [
          :external_api_call_error,
          "status:[404] - body[{\"message\":\"Couldn't find Movie\"}]"
        ]
      end
    end

    context "with title present in external api", vcr: { cassette_name: "pairguru/fetch_movie/django" } do
      let(:movie_title) { "Django" }

      it "returns success" do
        expect(fetch_movie).to be_success
      end

      it "returns parsed movie attributes" do
        expect(fetch_movie.success).to match(
          title: movie_title,
          rating: 8.4,
          plot: "With the help of a German bounty hunter, a freed slave sets out to rescue his wife from a brutal "\
                "Mississippi plantation owner.",
          poster: "https://pairguru-api.herokuapp.com/django.jpg"
        )
      end
    end
  end
end
