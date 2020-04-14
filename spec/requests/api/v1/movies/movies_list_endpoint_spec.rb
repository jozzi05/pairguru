require "rails_helper"

RSpec.describe "GET /api/v1/movies - movies list endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies" }

  let(:returned_movies) { parsed_json[:movies] }

  before { make_request }

  context "with no movies in DB" do
    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns empty movies array" do
      expect(returned_movies).to be_empty
    end
  end
end
