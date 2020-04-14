require "rails_helper"

RSpec.describe "GET /api/v1/movies/:id - movie details endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies/#{movie_id}" }

  context "with movie id missing in DB" do
    let(:movie_id) { "super_random_incorrect_movie_id" }

    before { make_request }

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end
  end
end
