require "rails_helper"
require_relative "movie_matchers"

RSpec.describe "GET /api/v1/movies/:id - movie details endpoint", type: :request do
  subject(:make_request) { get "/api/v1/movies/#{movie_id}", params: params }

  let(:params) { {} }

  context "with movie id missing in DB" do
    context "with integer id" do
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

    context "with string id" do
      let(:movie_id) { "super_random_id" }

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
  end

  context "with movie id present in DB" do
    include_context :movie_matchers

    let(:shrek) { create(:movie, title: "shrek") }
    let(:movie_id) { shrek.id }

    before { make_request }

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end

    it "returns movie" do
      expect(parsed_data).to match(
        movie_without_relations(shrek)
      )
    end

    it "returns empty array under 'included' key" do
      expect(parsed_included).to be_empty
    end

    context "with correct 'include' request param" do
      let(:params) { { include: "genre" } }

      it "returns movie present in DB with relationships info" do
        expect(parsed_data).to match(
          movie_with_relations(shrek)
        )
      end

      it "returns array containing genres under 'included' key" do
        expect(parsed_included).to contain_exactly(
          matching_genre(shrek.genre)
        )
      end
    end

    context "with incorrect 'include' param" do
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
