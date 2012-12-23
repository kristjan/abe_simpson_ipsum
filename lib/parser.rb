require 'nokogiri'

class Parser
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def data
    Nokogiri::HTML(File.open(filename))
  end

  def rants
    data.css('blockquote').map do |rant|
      rant.content.strip.gsub /\s+/, ' '
    end
  end
end

puts Parser.new('data/abe.html').rants
