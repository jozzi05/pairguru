class TitleBracketsValidator < ActiveModel::Validator
  PAIRS = {
    "]" => "[",
    "}" => "{",
    ")" => "("
  }.freeze

  def validate(record)
    queue = []
    record.title.each_char.with_index do |char, index|
      next queue << [char, index] if PAIRS.value?(char)

      if PAIRS.key?(char)
        prev_char, prev_index = queue.pop

        return record.errors[:title] << "contains unclosed brackets" if prev_char != PAIRS[char]
        return record.errors[:title] << "has empty brackets" if prev_index + 1 == index
      end
    end

    record.errors[:title] << "contains unclosed brackets" unless queue.empty?
  end
end
