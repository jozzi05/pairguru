require "rails_helper"

RSpec.describe "GET /api/v1/movies - movies list endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies" }

  before { make_request }

  context "with no movies in DB" do
    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
