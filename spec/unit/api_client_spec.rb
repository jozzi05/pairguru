require "rails_helper"

RSpec.describe ApiClient do
  describe "#get" do
    subject(:get_result) { described_class.get(url) }

    context "with incorrect url" do
      let(:url) { "incorrect_url" }

      it "returns failure" do
        expect(get_result).to be_failure
      end
    end
  end
end
