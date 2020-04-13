class MovieDetailsPage < BasePage
  include Rails.application.routes.url_helpers

  def initialize(page)
    @page = page
  end

  def has_title(title)
    expect(page).to(
      have_css("h1", exact_text: title),
      text_not_found_error(title, page.all("h1"))
    )

    self
  end

  def has_description(description)
    expect(page).to(
      have_css("div", exact_text: description),
      text_not_found_error(description, page.all("div"))
    )

    self
  end

  def has_plot(plot)
    expect(page).to(
      have_css("div.movie__plot", exact_text: plot),
      text_not_found_error(plot, page.all("div.movie__plot"))
    )

    self
  end

  def has_rating(rating)
    expect(page).to(
      have_css("div[data-movie='rating']", exact_text: "#{rating}/10"),
      text_not_found_error("#{rating}/10", page.all("div"))
    )

    self
  end

  def has_poster(poster)
    expect(page).to(
      have_css("img[data-movie='poster'][src='#{poster}']"),
      img_not_found_error(poster, page.all("img"))
    )

    self
  end

  private

  attr_reader :page
end
