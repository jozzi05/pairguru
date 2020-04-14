require "rails_helper"

RSpec.describe "GET /api/v1/movies/:id - movie details endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies/#{movie_id}" }

  context "with movie id missing in DB" do
    let(:movie_id) { 91919191919191 }

    before { make_request }

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end

    it "returns corresponding errors" do
      expect(parsed_errors).to contain_exactly(
        an_object_matching(code: "resource_not_found", key: "id")
      )
    end
  end

  context "with movie id present in DB" do
    let(:shrek) { create(:movie, title: "shrek") }
    let(:movie_id) { shrek.id }

    before { make_request }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns movie" do
      expect(parsed_data).to match(
        id: shrek.id.to_s,
        type: "movie",
        attributes: {
          title: shrek.title
        }
      )
    end
  end
end
