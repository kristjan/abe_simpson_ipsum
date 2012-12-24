require 'parser'
require 'test/unit'

class ParserTest < Test::Unit::TestCase
  def test_fresh_dictionary_includes_eol
    p = Parser.new("")
    assert p.dictionary.keys.include?(Parser::EOL)
  end

  def test_fresh_dictionary_includes_inline_separators
    p = Parser.new("")
    Parser::INLINE_SEPARATORS.each do |separator|
      assert p.dictionary.keys.include?(separator)
    end
  end

  def test_fresh_dictionary_exclues_eol_separators
    p = Parser.new("")
    Parser::EOL_SEPARATORS.each do |separator|
      assert !p.dictionary.keys.include?(separator)
    end
  end

  def test_fresh_dictionary_values_are_empty_array
    p = Parser.new("")
    p.dictionary.keys.each do |key|
      assert_equal [], p.dictionary[key]
    end
  end


  def test_parse_chains_the_first_fragment_from_eol
    p = Parser.new("")
    p.parse("I'm Bart Simpson")
    assert_equal ["I'm Bart Simpson"], p.dictionary[Parser::EOL]
  end

  def test_parse_chains_eol_separators_as_eol
    Parser::EOL_SEPARATORS.each do |separator|
      p = Parser.new("")
      p.parse("Me fail English#{separator} That's unpossible.")
      assert p.dictionary[Parser::EOL].include?("That's unpossible.")
    end
  end

  def test_parse_chains_inline_separators_as_themselves
    Parser::INLINE_SEPARATORS.each do |separator|
      p = Parser.new("")
      p.parse("Me fail English#{separator} That's unpossible.")
      assert_equal ["That's unpossible."], p.dictionary[separator]
    end
  end


  def test_random_fragment_picks_from_the_right_pool
    p = Parser.new("")
    corpus = "Lisa, vampires are make-believe; like elves, gremlins, and Eskimos."
    p.parse(corpus)
    assert_equal "like elves,", p.random_fragment(";")
    assert p.dictionary[","].include?(p.random_fragment(","))
  end
end
