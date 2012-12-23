require 'nokogiri'

class Parser
  EOL = '^'
  EOL_SEPARATORS    = %w[. ! ?]
  INLINE_SEPARATORS = %w[, ; ...]
  SEPARATORS        = INLINE_SEPARATORS + EOL_SEPARATORS

  module Util
    def self.extract(corpus)
      Nokogiri::HTML(corpus).css('blockquote').map do |str|
        str.content.strip.gsub /\s+/, ' '
      end
    end
  end
end
