require "rails_helper"

RSpec.describe ApiClient do
  describe "#get" do
    subject(:get_result) { described_class.get(url) }

    let(:returned_errors) { get_result.failure }

    context "with incorrect url" do
      let(:url) { "incorrect_url" }

      it "returns failure" do
        expect(get_result).to be_failure
      end

      it "returns failure code with message" do
        expect(returned_errors).to eq(:incorrect_url)
      end
    end
  end
end
