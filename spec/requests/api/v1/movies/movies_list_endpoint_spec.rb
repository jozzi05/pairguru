require "rails_helper"

RSpec.describe "GET /api/v1/movies - movies list endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies" }

  let(:returned_movies) { parsed_data }

  context "with no movies in DB" do
    before { make_request }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns empty movies array" do
      expect(returned_movies).to be_empty
    end
  end

  context "with movies in DB" do
    let!(:shrek) { create(:movie, title: "shrek") }
    let!(:godfather) { create(:movie, title: "Godfather") }

    before { make_request }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns movies present in DB" do
      expect(returned_movies).to contain_exactly(
        matching_movie(shrek),
        matching_movie(godfather)
      )
    end
  end

  def matching_movie(movie)
    an_object_matching(
      id: movie.id.to_s,
      type: "movie",
      attributes: {
        title: movie.title
      }
    )
  end
end
