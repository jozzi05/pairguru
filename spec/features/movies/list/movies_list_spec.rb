require "rails_helper"
require_relative "movies_list_page"

RSpec.describe "Movies list page", type: :system do
  subject(:movies_page) { MoviesListPage.new(page) }

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

    it "displays movie row in table", :aggregate_failures, :with_js, :with_job do
      perform_enqueued_jobs do
        visit "/movies"

        movies_page.has_row_with_movie(movie, movie_api_response)
      end
    end
  end
end
