require 'parser_util'
require 'test/unit'

class ParserTest < Test::Unit::TestCase
  def test_extracting_rants
    corpus = "<blockquote>Abe</blockquote><blockquote>Simpson</blockquote>"
    rants = Parser::Util.extract(corpus)
    assert_equal 2, rants.length
    assert rants.include?("Abe")
    assert rants.include?("Simpson")
  end

  def test_stripping_rants
    rants = Parser::Util.extract("<blockquote> Abe </blockquote>")
    assert_equal "Abe", rants.first
  end

  def test_squashing_rant_whitespace
    rants = Parser::Util.extract("<blockquote>Abe \t\n Simpson</blockquote>")
    assert_equal "Abe Simpson", rants.first
  end
end
