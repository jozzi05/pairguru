class BasePage
  include RSpec::Matchers

  def text_not_found_error(expected_text, elements)
    -> { "Expected: [#{expected_text.inspect}]\nGot: [#{elements.map { |el| el.text.inspect }.join('||')}]" }
  end

  def link_not_found_error(name, href, elements)
    proc do
      expected = { text: name, href: href }
      got = elements.map { |element| { text: element.text, href: element["href"] } }.join("\n")
      "Expected to find link: #{expected}\nFound links: [\n#{got}\n]"
    end
  end

  def img_not_found_error(src, elements)
    proc do
      expected = { src: src }
      got = elements.map { |element| { src: element["src"] } }.join("\n")
      "Expected to find image: #{expected}\nFound images: [\n#{got}\n]"
    end
  end
end
