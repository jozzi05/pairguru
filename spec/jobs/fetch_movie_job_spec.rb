require "rails_helper"

RSpec.describe FetchMovieJob, type: :job do
  describe "#perform" do
    subject(:perform) { described_class.new.perform("id" => id, "title" => title) }

    let(:id) { "super_random_id" }

    context "with title present in external api" do
      let(:title) { "Kill Bill 2" }

      it "broadcasts fetched movie details to the correct channel",
         vcr: { cassette_name: "pairguru/fetch_movie/kill_bill_2" } do
        expect { perform }.to broadcast_to("fetch_movie_channel_#{id}")
          .with(
            title: title,
            rating: 8.0,
            plot: "The Bride continues her quest of vengeance against her former boss and lover Bill, the reclusive "\
                "bouncer Budd and the treacherous, one-eyed Elle.",
            poster: "https://pairguru-api.herokuapp.com/kill_bill_2.jpg"
          )
      end
    end

    context "with title not present in external api", vcr: { cassette_name: "pairguru/fetch_movie/shrek" } do
      let(:title) { "Shrek" }

      it "does not broadcast message to the channel" do
        expect { perform }.not_to broadcast_to("fetch_movie_channel_#{id}")
      end

      it "logs error from api" do
        expect(Rails.logger).to receive(:info)
          .with("status:[404] - body[{\"message\":\"Couldn't find Movie\"}]")

        perform
      end
    end
  end
end
