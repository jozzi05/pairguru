require "rails_helper"

RSpec.describe ApiClient do
  describe "#get" do
    subject(:get_result) { described_class.get(url) }

    let(:returned_errors) { get_result.failure }

    context "with incorrect url" do
      let(:url) { "incorrect url" }

      it "returns failure" do
        expect(get_result).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_errors).to eq(:incorrect_url)
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
        expect(returned_errors).to match_array [
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
        ap returned_errors
        expect(returned_errors).to match_array [
          :external_api_call_error,
          "status:[404] - body[]"
        ]
      end
    end
  end
end
