require 'parser_util'

class Parser
  include Parser::Util

  attr_reader :dictionary, :rants

  def initialize(str)
    @rants = Util.extract(str)
    initialize_dictionary
    @rants.each{|rant| parse(rant)}
  end

  def initialize_dictionary
    @dictionary = {}
    [EOL, *INLINE_SEPARATORS].each do |separator|
      @dictionary[separator] = []
    end
  end

  def parse(str)
    separator = '^' # Beginning of sentence
    begin
      next_separator, index = Util.earliest_separator(str)
      if next_separator
        fragment, str = str.split(next_separator, 2)
        fragment.concat(next_separator)
      else
        fragment, str = str, ""
      end
      @dictionary[separator] << fragment.strip
      separator = EOL_SEPARATORS.include?(next_separator) ? '^' : next_separator
    end until str.empty?
  end
end
