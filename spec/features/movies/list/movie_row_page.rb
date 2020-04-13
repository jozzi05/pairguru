class MovieRowPage < BasePage
  def self.to_proc
    ->(row) { new(row) }
  end

  def initialize(row)
    @row = row
  end

  def has_title_with_link(title:, href:)
    expect(row).to(
      have_link(exact_text: title, href: href),
      link_not_found_error(title, href, row.find_all(:link))
    )

    self
  end

  def has_genre_with_link(genre:, href:)
    expect(row).to(
      have_link(exact_text: genre, href: href),
      link_not_found_error(genre, href, row.find_all(:link))
    )

    self
  end

  def has_description(description)
    expect(row).to(
      have_css("p", exact_text: description),
      text_not_found_error(description, row.all("p"))
    )

    self
  end

  def has_plot(plot)
    expect(row).to(
      have_css("p.movie__plot", exact_text: plot),
      text_not_found_error(plot, row.all("p.movie__plot"))
    )

    self
  end

  def has_rating(rating)
    expect(row).to(
      have_css("p[data-movie='rating']", exact_text: "#{rating}/10"),
      text_not_found_error("#{rating}/10", row.all("p"))
    )

    self
  end

  def has_poster(poster)
    expect(row).to(
      have_css("img[data-movie='poster'][src='#{poster}']"),
      img_not_found_error(poster, row.all("img"))
    )

    self
  end

  private

  attr_reader :row
end
