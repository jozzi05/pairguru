require "rails_helper"
require_relative "movie_matchers"

RSpec.describe "GET /api/v1/movies - movies list endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies", params: params }

  let(:params) { {} }
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
    include_context :movie_matchers

    let!(:shrek) { create(:movie, title: "shrek") }
    let!(:godfather) { create(:movie, title: "Godfather") }

    before { make_request }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns movies present in DB" do
      expect(returned_movies).to contain_exactly(
        movie_without_relations(shrek),
        movie_without_relations(godfather)
      )
    end

    it "returns empty array under 'included' key" do
      expect(parsed_included).to be_empty
    end

    context "with correct 'include' request param" do
      let(:params) { { include: "genre" } }

      it "returns movies present in DB with relationships info" do
        expect(returned_movies).to contain_exactly(
          movie_with_relations(shrek),
          movie_with_relations(godfather)
        )
      end

      it "returns array containing genres under 'included' key" do
        expect(parsed_included).to contain_exactly(
          matching_genre(shrek.genre),
          matching_genre(godfather.genre)
        )
      end
    end

    context "with incorrect include param" do
      let(:params) { { include: "random" } }

      it "returns status code 400" do
        expect(response).to have_http_status(400)
      end

      it "returns corresponding errors" do
        expect(parsed_errors).to contain_exactly(
          an_object_matching(
            code: "incorrect_include_value",
            key: "include",
            text: "allowed values: 'genre'"
          )
        )
      end
    end
  end
end
