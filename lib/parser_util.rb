require 'nokogiri'

class Parser
  EOL = '^'
  EOL_SEPARATORS    = %w[. ! ?]
  INLINE_SEPARATORS = %w[, ; : ...]
  SEPARATORS        = INLINE_SEPARATORS + EOL_SEPARATORS

  module Util
    def self.earliest_separator(str)
      SEPARATORS.map do |separator|
        index = str.index(separator)
        [separator, index]
      end.select do |separator, index|
        !index.nil?
      end.sort do |(separator1, index1), (separator2, index2)|
        if index1 == index2
          SEPARATORS.index(separator1) <=> SEPARATORS.index(separator2)
        else
          index1 <=> index2
        end
      end.first
    end

    def self.extract(corpus)
      Nokogiri::HTML(corpus).css('blockquote').map do |str|
        str.content.strip.gsub /\s+/, ' '
      end
    end
  end
end
