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
  end
end
