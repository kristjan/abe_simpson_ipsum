require 'nokogiri'

class Parser
  attr_reader :rants

  def initialize(str)
    @rants = extract(str)
  end

  def data
    Nokogiri::HTML(File.open(filename))
  end

  def extract(corpus)
    Nokogiri::HTML(corpus).css('blockquote').map do |str|
      str.content.strip.gsub /\s+/, ' '
    end
  end
end
