require "rails_helper"

RSpec.describe ApiClient do
  describe "#get" do
    subject(:get_result) { described_class.get(url) }

    let(:returned_error) { get_result.failure }

    context "with incorrect url" do
      let(:url) { "incorrect url" }

      it "returns failure" do
        expect(get_result).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_error).to eq(:incorrect_url)
      end
    end

    context "with external call timeout" do
      let(:url) { "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather" }

      around do |test|
        VCR.turned_off do
          stub_request(:any, /.*/).to_timeout
          test.call
        end
      end

      it "returns failure" do
        expect(get_result).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_error).to eq [
          :external_api_call_error,
          "Faraday::ConnectionFailed - execution expired"
        ]
      end
    end

    context "with api response error", vcr: { cassette_name: "api_client/api_error" } do
      let(:url) { "https://pairguru-api.herokuapp.com/api/v1/moviess/Godfather" }

      it "returns failure" do
        expect(get_result).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_error).to eq [
          :external_api_call_error,
          "status:[404] - body[]"
        ]
      end
    end

    context "with http 200 status code response", vcr: { cassette_name: "api_client/HTTP_200" } do
      let(:url) { "https://pairguru-api.herokuapp.com/api/v1/movies/Godfather" }

      it "returns success" do
        expect(get_result).to be_success
      end

      it "returns parsed json object" do
        expect(get_result.success).to match(
          data: {
            id: "6",
            type: "movie",
            attributes: {
              title: "Godfather",
              plot: "The aging patriarch of an organized crime dynasty transfers control "\
                    "of his clandestine empire to his reluctant son.",
              rating: 9.2,
              poster: "/godfather.jpg"
            }
          }
        )
      end
    end
  end
end
