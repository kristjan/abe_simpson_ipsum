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

  def generate_paragraph(length=(rand(4) + 2))
    (0...length).map { generate_sentence }.join(' ')
  end

  def generate_sentence
    separator = EOL
    "".tap do |sentence|
      begin
        fragment = random_fragment(separator)
        sentence.concat "#{fragment} "
        separator, index = Util.earliest_separator(fragment)
      end until EOL_SEPARATORS.include?(separator)
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

  def random_fragment(separator)
    set = dictionary[separator]
    set[rand(set.size)]
  end
end
