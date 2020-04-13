require "rails_helper"
require_relative "movie_details_page"

RSpec.describe "Movies details page", type: :system do
  subject(:movie_page) { MovieDetailsPage.new(page) }

  describe "#UI", :with_dry_monads_stubs do
    let!(:movie) { create(:movie) }
    let(:movie_api_response) do
      {
        title: movie.title,
        plot: "very nice plot",
        poster: "https://super_awesome_image.xyz",
        rating: "5"
      }
    end

    around do |test|
      Container.stub(:fetch_movie, stubbed_success { movie_api_response }, &test)
    end

    before { visit "/movies/#{movie.id}" }

    it "displays movie details", :aggregate_failures, :with_js, :with_job do
      perform_enqueued_jobs do
        movie_page
          .has_title(movie.title)
          .has_description(movie.description)
          .has_plot(movie_api_response[:plot])
          .has_poster(movie_api_response[:poster])
          .has_rating(movie_api_response[:rating])
      end
    end
  end
end
