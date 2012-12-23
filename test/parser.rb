require 'parser'
require 'test/unit'

class ParserTest < Test::Unit::TestCase
  def test_extracting_rants
    corpus = "<blockquote>Abe</blockquote><blockquote>Simpson</blockquote>"
    p = Parser.new(corpus)
    assert_equal 2, p.rants.length
    assert p.rants.include?("Abe")
    assert p.rants.include?("Simpson")
  end

  def test_stripping_rants
    p = Parser.new("<blockquote> Abe </blockquote>")
    assert_equal "Abe", p.rants.first
  end

  def test_squashing_rant_whitespace
    p = Parser.new("<blockquote>Abe \t\n Simpson</blockquote>")
    assert_equal "Abe Simpson", p.rants.first
  end
end
